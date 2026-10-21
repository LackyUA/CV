//
//  SectionsMenuView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// White panel with the owner's name and the section buttons.
/// Slides up from the bottom while the profile badge scales in on its top edge.
struct SectionsMenuView: View {

    let onSelect: (CVSection) -> Void

    @State private var isPresented = false

    var body: some View {
        GeometryReader { geometry in
            let panelTop = geometry.size.height / 6

            VStack(spacing: 0) {
                Color.clear
                    .frame(height: panelTop)

                SectionsPanel(onSelect: onSelect)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.ignoresSafeArea(edges: .bottom))
                    .overlay(alignment: .top) {
                        ProfileBadge()
                            .scaleEffect(isPresented ? 1 : 0.01)
                            .offset(y: -ProfileBadge.size / 2)
                    }
            }
            .offset(y: isPresented ? 0 : geometry.size.height)
        }
        .onAppear {
            withAnimation(.spring(duration: 0.7, bounce: 0.05)) {
                isPresented = true
            }
        }
    }

}

// MARK: - Panel content

private struct SectionsPanel: View {

    let onSelect: (CVSection) -> Void

    var body: some View {
        VStack(spacing: Spacing.s) {
            Color.clear
                .frame(height: 70)

            NameHeader()
                .frame(height: 70)

            SectionButtons(onSelect: onSelect)
                .padding(.horizontal, Spacing.m)
                .padding(.bottom, Spacing.s)
        }
    }

}

private struct NameHeader: View {

    var body: some View {
        VStack(spacing: 0) {
            Text("Dmytro")
                .typography(.Heading.Level1.bold)
                .frame(maxHeight: .infinity)
            Text("Dobrovolskyy")
                .typography(.Heading.Level1.bold)
                .frame(maxHeight: .infinity)
        }
        .foregroundStyle(Colors.darkGray.swiftUIColor)
    }

}

private struct SectionButtons: View {

    let onSelect: (CVSection) -> Void

    var body: some View {
        VStack(spacing: Spacing.xs) {
            ForEach(CVSection.allCases) { section in
                Button {
                    onSelect(section)
                } label: {
                    Text(section.title)
                        .typography(.Heading.Level2.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Colors.buttonGray.swiftUIColor)
                        .rounded(.s)
                }
                .buttonStyle(.plain)
            }
        }
    }

}

// MARK: - Profile badge

/// Round profile photo with a dark border, sitting on a horizontal line across the panel's top edge.
private struct ProfileBadge: View {

    static let size: CGFloat = 120
    private static let borderWidth = size / 20

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Colors.darkGray.swiftUIColor)
                .frame(height: Self.borderWidth)

            Images.profileImage.swiftUIImage
                .resizable()
                .scaledToFill()
                .frame(width: Self.size, height: Self.size)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .strokeBorder(Colors.darkGray.swiftUIColor, lineWidth: Self.borderWidth)
                }
        }
    }

}

#Preview {
    ZStack {
        Colors.accent.swiftUIColor.ignoresSafeArea()
        SectionsMenuView { _ in }
    }
}
