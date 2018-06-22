#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Foundation

extension NSString {
    private static var invalidCharacters: CharacterSet = {
        var invalidCharacters = CharacterSet()

        let invalidCharacterSets: [CharacterSet] = [
            .whitespacesAndNewlines,
            .illegalCharacters,
            .controlCharacters,
            .punctuationCharacters,
            .nonBaseCharacters,
            .symbols
        ]

        for invalidSet in invalidCharacterSets {
            invalidCharacters.formUnion(invalidSet)
        }

        return invalidCharacters
    }()

    @objc(qck_c99ExtendedIdentifier)
    public var c99ExtendedIdentifier: String {
        let validComponents = components(separatedBy: NSString.invalidCharacters)
        let result = validComponents.joined(separator: "_")

        return result.isEmpty ? "_" : result
    }
}

/// Extension methods or properties for NSObject subclasses are somehow invisible
/// from the Objective-C runtime on static linking, so let's make a wrapper class.
///
/// See: https://github.com/Quick/Quick/issues/785
@objc
public class QCKObjCStringUtils: NSObject {
    override private init() {}

    @objc
    public static func c99ExtendedIdentifier(from string: String) -> String {
        return string.c99ExtendedIdentifier
    }
}
#endif
