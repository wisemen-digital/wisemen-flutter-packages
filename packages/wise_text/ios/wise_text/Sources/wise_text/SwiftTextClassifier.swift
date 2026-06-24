import Foundation

@objc public class SwiftTextClassifier: NSObject {
    /// Classifies `text` and returns the detected ranges packed as
    /// (start, length, typeCode) Int32 triples in a `Data` buffer.
    ///
    /// Raw bytes are used as the bridge type because they map cheaply to a Dart
    /// `NSData` over the FFI/Objective-C interop layer without any string
    /// encoding. Only the *detected* ranges are reported; the Dart side already
    /// holds the source string and rebuilds the plain-text gaps from these
    /// offsets. Offsets are UTF-16 code-unit based (`NSString` length), which
    /// matches Dart `String` indexing. On any failure an empty buffer is
    /// returned, which the Dart side renders as a single plain-text span.
    @objc public func classifyText(text: String) -> Data {
        let triples = classify(text)
        return triples.withUnsafeBytes { Data($0) }
    }

    private func classify(_ text: String) -> [Int32] {
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
            return []
        }

        let nsText = text as NSString
        let fullRange = NSRange(location: 0, length: nsText.length)
        let matches = detector.matches(in: text, options: [], range: fullRange)

        var triples: [Int32] = []
        triples.reserveCapacity(matches.count * 3)

        for match in matches {
            guard let code = Self.typeCode(for: match) else { continue }
            triples.append(Int32(match.range.location))
            triples.append(Int32(match.range.length))
            triples.append(code)
        }

        return triples
    }

    /// Maps a match's result type to a stable integer identifier shared with the
    /// Dart side (`WiseTextItemType.fromCode`). Returns nil for unsupported types.
    private static func typeCode(for match: NSTextCheckingResult) -> Int32? {
        switch match.resultType {
        case .date: return 0
        case .address: return 1
        case .link:
            // A `mailto:` link is reported to Dart as an email rather than a URL.
            return match.url?.scheme?.lowercased() == "mailto" ? 3 : 2
        case .phoneNumber: return 4
        default: return nil
        }
    }
}
