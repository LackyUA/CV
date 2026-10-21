//
//  SectionsMenuView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Night panel with the owner's name and the section buttons.
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
                    .background(Colors.bg200.swiftUIColor.ignoresSafeArea(edges: .bottom))
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
                .typography(.Display.name)
                .frame(maxHeight: .infinity)
            Text("Dobrovolskyy")
                .typography(.Display.name)
                .frame(maxHeight: .infinity)
        }
        .foregroundStyle(Colors.textPrimary.swiftUIColor)
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
                        .typography(.Interface.buttonLarge)
                        .foregroundStyle(Colors.textPrimary.swiftUIColor)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .rounded(.infinity)
                        .backgroundBlur(.regular, tint: Colors.glassFill.swiftUIColor)
                        .border(color: Colors.glassStroke.swiftUIColor, lineWidth: .m)
                        .boxShadow(.glass)
                }
                .buttonStyle(.plain)
            }
        }
    }

}

// MARK: - Profile badge

/// Round profile photo with a neon ring, sitting on a glowing horizon line across the panel's top edge.
private struct ProfileBadge: View {

    static let size: CGFloat = 120
    private static let borderWidth = size / 20

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Colors.neonCyan.swiftUIColor)
                .frame(height: Self.borderWidth)

            Images.profileImage.swiftUIImage
                .resizable()
                .scaledToFill()
                .frame(width: Self.size, height: Self.size)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .strokeBorder(Colors.neonMagenta.swiftUIColor, lineWidth: Self.borderWidth)
                }
                .boxShadow(.glowMagenta, shape: RoundedRectangle(cornerRadius: CornerRadius.infinity.rawValue))
        }
    }

}

#Preview {
    ZStack {
        Colors.bg100.swiftUIColor.ignoresSafeArea()
        SectionsMenuView { _ in }
    }
}
