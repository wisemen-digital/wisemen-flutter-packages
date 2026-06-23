import Foundation

/// A span of classified text. `text` is the matched substring, `type` is one of
/// the supported detector types ("date", "address", "link", "phoneNumber",
/// "transitInformation") or "text" for the plain runs in between, and
/// `rawValue` is a normalized representation of the match.
struct ItemSpan: Codable {
    let text: String
    let type: String
}

@objc public class SwiftTextClassifier: NSObject {
    /// Classifies `text` and returns a JSON array of spans as a String.
    ///
    /// A JSON string is used as the bridge type because it maps cleanly to a
    /// Dart `String` over the FFI/Objective-C interop layer; the Dart side
    /// decodes it into typed models.
    @objc public func classifyText(text: String) -> String {
        let spans = classify(text)
        guard
            let data = try? JSONEncoder().encode(spans),
            let json = String(data: data, encoding: .utf8)
        else {
            // Fall back to a single plain-text span so callers always get
            // valid JSON back.
            return Self.fallbackJSON(for: text)
        }
        return json
    }

    private func classify(_ text: String) -> [ItemSpan] {
        // NSDataDetector is a specialized NSRegularExpression subclass and only
        // supports the "data" checking types below. The other CheckingType
        // cases (.quote, .dash, .replacement, .correction, .regularExpression)
        // are not valid for NSDataDetector and would make the initializer throw.
        let types: NSTextCheckingResult.CheckingType = [
            .date,
            .address,
            .link,
            .phoneNumber
        ]

        guard let detector = try? NSDataDetector(types: types.rawValue) else {
            return [ItemSpan(text: text, type: "text")]
        }

        let nsText = text as NSString
        let fullRange = NSRange(location: 0, length: nsText.length)
        let matches = detector.matches(in: text, options: [], range: fullRange)

        var spans: [ItemSpan] = []
        var cursor = 0

        for match in matches {
            // Emit the plain text between the previous match and this one.
            if match.range.location > cursor {
                let gap = NSRange(location: cursor, length: match.range.location - cursor)
                let gapText = nsText.substring(with: gap)
                spans.append(ItemSpan(text: gapText, type: "text"))
            }

            let matchText = nsText.substring(with: match.range)
            spans.append(
                ItemSpan(
                    text: matchText,
                    type: Self.typeName(for: match),
                )
            )

            cursor = match.range.location + match.range.length
        }

        // Emit any trailing plain text after the last match.
        if cursor < nsText.length {
            let tail = NSRange(location: cursor, length: nsText.length - cursor)
            let tailText = nsText.substring(with: tail)
            spans.append(ItemSpan(text: tailText, type: "text"))
        }

        return spans
    }

    /// Maps a match's result type to a stable string identifier.
    private static func typeName(for match: NSTextCheckingResult) -> String {
        switch match.resultType {
        case .date: return "date"
        case .address: return "address"
        case .link: return "link"
        case .phoneNumber: return "phoneNumber"
        default: return "text"
        }
    }

    /// Builds a valid single-span JSON document for the fallback path.
    private static func fallbackJSON(for text: String) -> String {
        let span = ItemSpan(text: text, type: "text")
        if let data = try? JSONEncoder().encode([span]),
           let json = String(data: data, encoding: .utf8) {
            return json
        }
        return "[]"
    }
}
