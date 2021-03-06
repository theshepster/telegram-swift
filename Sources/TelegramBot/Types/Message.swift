// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation
import SwiftyJSON

/// This object represents a message.
///
/// - SeeAlso: <https://core.telegram.org/bots/api#message>

public struct Message: JsonConvertible {
    /// Original JSON for fields not yet added to Swift structures.
    public var json: JSON

    /// Unique message identifier
    public var message_id: Int {
        get { return json["message_id"].intValue }
        set { json["message_id"].intValue = newValue }
    }

    /// Optional. Sender, can be empty for messages sent to channels
    public var from: User? {
        get {
            let value = json["from"]
            return value.isNullOrUnknown ? nil : User(json: value)
        }
        set {
            json["from"] = newValue?.json ?? nil
        }
    }

    /// Date the message was sent in Unix time
    public var date_unix: Int {
        get { return json["date"].intValue }
        set { json["date"].intValue = newValue }
    }

    /// Conversation the message belongs to
    public var chat: Chat {
        get { return Chat(json: json["chat"]) }
        set { json["chat"] = newValue.json }
    }

    /// Optional. For forwarded messages, sender of the original message
    public var forward_from: User? {
        get {
            let value = json["forward_from"]
            return value.isNullOrUnknown ? nil : User(json: value)
        }
        set {
            json["forward_from"] = newValue?.json ?? nil
        }
    }

    /// Optional. For messages forwarded from a channel, information about the original channel
    public var forward_from_chat: Chat? {
        get {
            let value = json["forward_from_chat"]
            return value.isNullOrUnknown ? nil : Chat(json: value)
        }
        set {
            json["forward_from_chat"] = newValue?.json ?? nil
        }
    }

    /// Optional. For forwarded messages, date the original message was sent in Unix time
    public var forward_date_unix: Int? {
        get { return json["forward_date"].int }
        set { json["forward_date"].int = newValue }
    }

    /// Optional. For replies, the original message. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.
    public var reply_to_message: Message? {
        get {
            let value = json["reply_to_message"]
            return value.isNullOrUnknown ? nil : Message(json: value)
        }
        set {
            json["reply_to_message"] = newValue?.json ?? nil
        }
    }

    /// Optional. Date the message was last edited in Unix time
    public var edit_date_unix: Int? {
        get { return json["edit_date"].int }
        set { json["edit_date"].int = newValue }
    }

    /// Optional. For text messages, the actual UTF-8 text of the message, 0-4096 characters.
    public var text: String? {
        get { return json["text"].string }
        set { json["text"].string = newValue }
    }

    /// Optional. For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text
    public var entities: [MessageEntity] {
        get { return json["entities"].arrayValue() }
        set { json["entities"] = newValue.isEmpty ? nil : JSON(newValue) }
    }

    /// Optional. Message is an audio file, information about the file
    public var audio: Audio? {
        get {
            let value = json["audio"]
            return value.isNullOrUnknown ? nil : Audio(json: value)
        }
        set {
            json["audio"] = newValue?.json ?? nil
        }
    }

    /// Optional. Message is a general file, information about the file
    public var document: Document? {
        get {
            let value = json["document"]
            return value.isNullOrUnknown ? nil : Document(json: value)
        }
        set {
            json["document"] = newValue?.json ?? nil
        }
    }

    /// Optional. Message is a photo, available sizes of the photo
    public var photo: [PhotoSize] {
        get { return json["photo"].arrayValue() }
        set { json["photo"] = newValue.isEmpty ? nil : JSON(newValue) }
    }

    /// Optional. Message is a sticker, information about the sticker
    public var sticker: Sticker? {
        get {
            let value = json["sticker"]
            return value.isNullOrUnknown ? nil : Sticker(json: value)
        }
        set {
            json["sticker"] = newValue?.json ?? nil
        }
    }

    /// Optional. Message is a video, information about the video
    public var video: Video? {
        get {
            let value = json["video"]
            return value.isNullOrUnknown ? nil : Video(json: value)
        }
        set {
            json["video"] = newValue?.json ?? nil
        }
    }

    /// Optional. Message is a voice message, information about the file
    public var voice: Voice? {
        get {
            let value = json["voice"]
            return value.isNullOrUnknown ? nil : Voice(json: value)
        }
        set {
            json["voice"] = newValue?.json ?? nil
        }
    }

    /// Optional. Caption for the document, photo or video, 0-200 characters
    public var caption: String? {
        get { return json["caption"].string }
        set { json["caption"].string = newValue }
    }

    /// Optional. Message is a shared contact, information about the contact
    public var contact: Contact? {
        get {
            let value = json["contact"]
            return value.isNullOrUnknown ? nil : Contact(json: value)
        }
        set {
            json["contact"] = newValue?.json ?? nil
        }
    }

    /// Optional. Message is a shared location, information about the location
    public var location: Location? {
        get {
            let value = json["location"]
            return value.isNullOrUnknown ? nil : Location(json: value)
        }
        set {
            json["location"] = newValue?.json ?? nil
        }
    }

    /// Optional. Message is a venue, information about the venue
    public var venue: Venue? {
        get {
            let value = json["venue"]
            return value.isNullOrUnknown ? nil : Venue(json: value)
        }
        set {
            json["venue"] = newValue?.json ?? nil
        }
    }

    /// Optional. A new member was added to the group, information about them (this member may be the bot itself)
    public var new_chat_member: User? {
        get {
            let value = json["new_chat_member"]
            return value.isNullOrUnknown ? nil : User(json: value)
        }
        set {
            json["new_chat_member"] = newValue?.json ?? nil
        }
    }

    /// Optional. A member was removed from the group, information about them (this member may be the bot itself)
    public var left_chat_member: User? {
        get {
            let value = json["left_chat_member"]
            return value.isNullOrUnknown ? nil : User(json: value)
        }
        set {
            json["left_chat_member"] = newValue?.json ?? nil
        }
    }

    /// Optional. A chat title was changed to this value
    public var new_chat_title: String? {
        get { return json["new_chat_title"].string }
        set { json["new_chat_title"].string = newValue }
    }

    /// Optional. A chat photo was change to this value
    public var new_chat_photo: [PhotoSize] {
        get { return json["new_chat_photo"].arrayValue() }
        set { json["new_chat_photo"] = newValue.isEmpty ? nil : JSON(newValue) }
    }

    /// Optional. Service message: the chat photo was deleted
    public var delete_chat_photo: Bool? {
        get { return json["delete_chat_photo"].bool }
        set { json["delete_chat_photo"].bool = newValue }
    }

    /// Optional. Service message: the group has been created
    public var group_chat_created: Bool? {
        get { return json["group_chat_created"].bool }
        set { json["group_chat_created"].bool = newValue }
    }

    /// Optional. Service message: the supergroup has been created. This field can‘t be received in a message coming through updates, because bot can’t be a member of a supergroup when it is created. It can only be found in reply_to_message if someone replies to a very first message in a directly created supergroup.
    public var supergroup_chat_created: Bool? {
        get { return json["supergroup_chat_created"].bool }
        set { json["supergroup_chat_created"].bool = newValue }
    }

    /// Optional. Service message: the channel has been created. This field can‘t be received in a message coming through updates, because bot can’t be a member of a channel when it is created. It can only be found in reply_to_message if someone replies to a very first message in a channel.
    public var channel_chat_created: Bool? {
        get { return json["channel_chat_created"].bool }
        set { json["channel_chat_created"].bool = newValue }
    }

    /// Optional. The group has been migrated to a supergroup with the specified identifier. This number may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier.
    public var migrate_to_chat_id: Int64? {
        get { return json["migrate_to_chat_id"].int64 }
        set { json["migrate_to_chat_id"].int64 = newValue }
    }

    /// Optional. The supergroup has been migrated from a group with the specified identifier. This number may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier.
    public var migrate_from_chat_id: Int64? {
        get { return json["migrate_from_chat_id"].int64 }
        set { json["migrate_from_chat_id"].int64 = newValue }
    }

    /// Optional. Specified message was pinned. Note that the Message object in this field will not contain further reply_to_message fields even if it is itself a reply.
    public var pinned_message: Message? {
        get {
            let value = json["pinned_message"]
            return value.isNullOrUnknown ? nil : Message(json: value)
        }
        set {
            json["pinned_message"] = newValue?.json ?? nil
        }
    }

    public init(json: JSON = [:]) {
        self.json = json
    }
}
