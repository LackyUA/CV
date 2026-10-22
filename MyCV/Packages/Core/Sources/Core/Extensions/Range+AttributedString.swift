//
//  Range+AttributedString.swift
//  Core
//
//  Created by Serhii Yelmanov on 24.07.2026.
//

import Foundation

extension Range where Bound == AttributedString.Index {

    /// Creates an attributed string range from a range of indices in the attributed string's
    /// underlying character content.
    ///
    /// Returns `nil` if either bound can't be represented in `attributedString`.
    public init?<S>(_ range: Range<String.Index>, within attributedString: S) where S: AttributedStringProtocol {
        guard let lowerBound = AttributedString.Index(range.lowerBound, within: attributedString),
              let upperBound = AttributedString.Index(range.upperBound, within: attributedString) else {
            return nil
        }
        self = lowerBound..<upperBound
    }
}
