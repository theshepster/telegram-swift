// Telegram Bot SDK for Swift (unofficial).
// (c) 2015 - 2016 Andrey Fidrya. MIT license. See LICENSE for more information.

import Foundation

public class Router {
	public typealias Handler = (context: Context) throws -> Bool
	public typealias Path = (contentType: ContentType, handler: Handler)
	
    public var caseSensitive = false
    public var charactersToBeSkipped: CharacterSet? = CharacterSet.whitespacesAndNewlines

	public var bot: TelegramBot

	public lazy var partialMatch: Handler? = { context in
		context.respondAsync("❗ Part of your input was ignored: \(context.args.scanRestOfString())")
		return true
	}
	
	public lazy var unmatched: Handler? = { context in
        guard context.privateChat else { return false }
        guard let command = context.args.scanWord() else { return false }
		context.respondAsync("Unrecognized command: \(command). Type /help for help.")
		return true
	}

	public lazy var unsupportedContentType: Handler? = { context in
        guard context.privateChat else { return false }
        if !context.args.isAtEnd {
            context.respondAsync("Unsupported action.")
        } else {
            context.respondAsync("Unsupported content type.")
        }
		return true
	}
    
    public var handler: Handler {
        return { [weak self] context in
            try self?.process(update: context.update)
            return true
        }
    }

	public init(bot: TelegramBot) {
		self.bot = bot
    }
    
    public convenience init(bot: TelegramBot, setup: @noescape (router: Router)->()) {
        self.init(bot: bot)
        setup(router: self)
    }
	
	public func add(_ contentType: ContentType, _ handler: (Context) throws -> Bool) {
		paths.append(Path(contentType, handler))
	}
	
	public func add(_ command: Command, _ handler: (Context) throws -> Bool) {
		paths.append(Path(.command(command), handler))
	}

    public func add(_ commands: [Command], _ handler: (Context) throws -> Bool) {
        paths.append(Path(.commands(commands), handler))
    }
    
	@discardableResult
    public func process(update: Update, properties: [String: AnyObject] = [:]) throws -> Bool {
		let string = update.message?.extractCommand(for: bot) ?? (update.callback_query?.data ?? "")
        let scanner = Scanner(string: string)
        scanner.caseSensitive = caseSensitive
        scanner.charactersToBeSkipped = charactersToBeSkipped
		let originalScanLocation = scanner.scanLocation
		
		for path in paths {
			var command = ""
            var startsWithSlash = false
            if !match(contentType: path.contentType, update: update, commandScanner: scanner, userCommand: &command, startsWithSlash: &startsWithSlash) {
				scanner.scanLocation = originalScanLocation
				continue;
			}
			
            let context = Context(bot: bot, update: update, scanner: scanner, command: command, startsWithSlash: startsWithSlash, properties: properties)
			let handler = path.handler

			if try handler(context: context) {
				try checkPartialMatch(context: context)
                return true
			}

			scanner.scanLocation = originalScanLocation
		}

		if update.message != nil && !string.isEmpty {
			if let unmatched = unmatched {
                let context = Context(bot: bot, update: update, scanner: scanner, command: "", startsWithSlash: false, properties: properties)
				return try unmatched(context: context)
			}
		} else {
			if let unsupportedContentType = unsupportedContentType {
				let context = Context(bot: bot, update: update, scanner: scanner, command: "", startsWithSlash: false, properties: properties)
				return try unsupportedContentType(context: context)
			}
		}
		
		return false
    }
	
    func match(contentType: ContentType, update: Update, commandScanner: Scanner, userCommand: inout String, startsWithSlash: inout Bool) -> Bool {
		
		if let message = update.message {
            switch contentType {
            case .command(let command):
                guard let result = command.fetchFrom(commandScanner, caseSensitive: caseSensitive) else {
                    return false // Does not match path command
                }
                userCommand = result.command
                startsWithSlash = result.startsWithSlash
                return true
            case .commands(let commands):
                let originalScanLocation = commandScanner.scanLocation
                for command in commands {
                    guard let result = command.fetchFrom(commandScanner, caseSensitive: caseSensitive) else {
                        commandScanner.scanLocation = originalScanLocation
                        continue
                    }
                    userCommand = result.command
                    startsWithSlash = result.startsWithSlash
                    return true
                }
                return false
            case .from: return message.from != nil
            case .forward_from: return message.forward_from != nil
            case .forward_from_chat: return message.forward_from_chat != nil
            case .forward_date: return message.forward_date_unix != nil
            case .reply_to_message: return message.reply_to_message != nil
            case .edit_date: return message.edit_date_unix != nil
            case .text: return message.text != nil
            case .entities: return !message.entities.isEmpty
            case .audio: return message.audio != nil
            case .document: return message.document != nil
            case .photo: return !message.photo.isEmpty
            case .sticker: return message.sticker != nil
            case .video: return message.video != nil
            case .voice: return message.voice != nil
            case .caption: return message.caption != nil
            case .contact: return message.contact != nil
            case .location: return message.location != nil
            case .venue: return message.venue != nil
            case .new_chat_member: return message.new_chat_member != nil
            case .left_chat_member: return message.left_chat_member != nil
            case .new_chat_title: return message.new_chat_title != nil
            case .new_chat_photo: return !message.new_chat_photo.isEmpty
            case .delete_chat_photo: return message.delete_chat_photo ?? false
            case .group_chat_created: return message.group_chat_created ?? false
            case .supergroup_chat_created: return message.supergroup_chat_created ?? false
            case .channel_chat_created: return message.channel_chat_created ?? false
            case .migrate_to_chat_id: return message.migrate_to_chat_id != nil
            case .migrate_from_chat_id: return message.migrate_from_chat_id != nil
            case .pinned_message: return message.pinned_message != nil
            default: break
            }
        } else {
            switch contentType {
            case .callback_query(let data):
                if let data = data {
                    return update.callback_query?.data == data
                }
                return update.callback_query != nil
            default: break
            }
        }
        return false
	}
	
	// After processing the command, check that no unprocessed text is left
    @discardableResult
	func checkPartialMatch(context: Context) throws -> Bool {

		// Note that scanner.atEnd automatically ignores charactersToBeSkipped
		if !context.args.isAtEnd {
			// Partial match
			if let handler = partialMatch {
				return try handler(context: context)
			}
		}
		
		return true
	}
	
	var paths = [Path]()
}
