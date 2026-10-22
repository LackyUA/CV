//
//  Array+Chunked.swift
//  Core
//
//  Created by Serhii Yelmanov on 15.07.2025.
//

extension Array {

    /// Splits the array into chunks of a given size.
    public func chunked(into size: Int) -> [ArraySlice<Element>] {
        stride(from: 0, to: count, by: size).map { index in
            self[index ..< Swift.min(index + size, count)]
        }
    }
}
