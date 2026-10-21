//
//  ScreenHeaderImage.swift
//  MyCV
//

import SwiftUI

/// Full-width illustration shown at the top of a section screen.
struct ScreenHeaderImage: View {

    let name: String

    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
    }

}

extension View {

    /// Makes a view usable as an edge-to-edge, separator-less row inside a `List`.
    func plainListHeaderRow() -> some View {
        self
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
    }

}
