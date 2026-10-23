//
//  String+Mask.swift
//  Core
//

extension String {

    /// Returns the digits of the string in the format of a mask.
    ///
    /// The mask replaces each placeholder with the next digit of the string. A digit in the mask must be equal to
    /// the next digit of the string. Each other character of the mask stays in the result. The method ignores all
    /// characters of the string that are not digits.
    ///
    /// ```swift
    /// "+380668422448".applyingMask("+380 (##) #### ###") // "+380 (66) 8422 448"
    /// ```
    ///
    /// - Parameters:
    ///   - mask: The format of the result.
    ///   - placeholder: The character in the mask that a digit replaces. The default value is `#`.
    /// - Returns: The formatted string, or `nil` if the digits of the string do not agree with the mask.
    public func applyingMask(_ mask: String, placeholder: Character = "#") -> String? {
        var digits = filter(\.isASCIIDigit)[...]
        var result = ""
        for character in mask {
            if character == placeholder || character.isASCIIDigit {
                guard let digit = digits.popFirst(), character == placeholder || character == digit else {
                    return nil
                }
                result.append(digit)
            } else {
                result.append(character)
            }
        }
        return digits.isEmpty ? result : nil
    }
}

extension Character {

    /// A Boolean value that indicates whether the character is one of the ASCII digits `0` to `9`.
    fileprivate var isASCIIDigit: Bool {
        isASCII && isWholeNumber
    }
}
