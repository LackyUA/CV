//
//  Sequence+Ranked.swift
//  Core
//
//  Created by Andrii Vysotskyi on 15.06.2026.
//

extension Sequence {

    /// Returns a new collection of elements ordered by a reference ranking.
    ///
    /// Elements are ordered according to their position in the provided `order`
    /// list. Each element is mapped into the ordering space using `reference`.
    ///
    /// ### Ordering rules
    /// - Elements whose reference value exists in `order` are ordered by their
    ///   index in `order` (lower index = higher priority).
    /// - Elements whose reference value is not present in `order` are placed after
    ///   all known elements.
    /// - Elements missing from `order` retain their relative order from the
    ///   original sequence.
    public func ranked<S: Sequence>(
        by order: S, reference: (Element) -> S.Element
    ) -> [Element] where S.Element: Hashable {
        let ranks = Dictionary(grouping: order.enumerated(), by: \.element)
            .compactMapValues(\.first?.offset)
        let ranked = enumerated()
            .sorted { lhs, rhs in
                let lhsRank = ranks[reference(lhs.element)]
                let rhsRank = ranks[reference(rhs.element)]

                if let lhsRank, let rhsRank {
                    return lhsRank < rhsRank
                }
                if lhsRank != nil {
                    return true
                }
                if rhsRank != nil {
                    return false
                }
                return lhs.offset < rhs.offset
            }
            .map(\.element)
        return ranked
    }
}
