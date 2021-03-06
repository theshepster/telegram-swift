// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation
import SwiftyJSON

/// This object represents an inline keyboard that appears right next to the message it belongs to.
/// Warning: Inline keyboards are currently being tested and are not available in channels yet. For now, feel free to use them in one-on-one chats or groups.
///
/// - SeeAlso: <https://core.telegram.org/bots/api#inlinekeyboardmarkup>

public struct InlineKeyboardMarkup: JsonConvertible {
    /// Original JSON for fields not yet added to Swift structures.
    public var json: JSON

    /// Array of button rows, each represented by an Array of InlineKeyboardButton objects
    public var inline_keyboard: [[InlineKeyboardButton]] {
        get { return json["inline_keyboard"].twoDArrayValue() }
        set {
            var rowsJson = [JSON]()
            rowsJson.reserveCapacity(newValue.count)
            for row in newValue {
                var colsJson = [JSON]()
                colsJson.reserveCapacity(row.count)
                for col in row {
                    let json = col.json
                    colsJson.append(json)
                }
                rowsJson.append(JSON(colsJson))
            }
            json["inline_keyboard"] = JSON(rowsJson)
        }
    }

    public init(json: JSON = [:]) {
        self.json = json
    }
}
