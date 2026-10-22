//
//  Collection+Safe.swift
//  Core
//
//  Created by Serhii Yelmanov on 14.07.2025.
//

extension Collection {

    // Returns the element at the specified index if it is within bounds, otherwise nil.
    public subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
