//
//  SectionsMenuView.swift
//  MyCV
//

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
        VStack(spacing: 10) {
            Color.clear
                .frame(height: 70)

            NameHeader()
                .frame(height: 70)

            SectionButtons(onSelect: onSelect)
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
        }
    }

}

private struct NameHeader: View {

    var body: some View {
        VStack(spacing: 0) {
            Text("Dmytro")
                .frame(maxHeight: .infinity)
            Text("Dobrovolskyy")
                .frame(maxHeight: .infinity)
        }
        .font(.system(size: 24, weight: .bold))
        .foregroundStyle(Color(.darkGray))
    }

}

private struct SectionButtons: View {

    let onSelect: (CVSection) -> Void

    var body: some View {
        VStack(spacing: 8) {
            ForEach(CVSection.allCases) { section in
                Button {
                    onSelect(section)
                } label: {
                    Text(section.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.buttonGray), in: .rect(cornerRadius: 8))
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
                .fill(Color(.darkGray))
                .frame(height: Self.borderWidth)

            Image("profileImage")
                .resizable()
                .scaledToFill()
                .frame(width: Self.size, height: Self.size)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .strokeBorder(Color(.darkGray), lineWidth: Self.borderWidth)
                }
        }
    }

}

#Preview {
    ZStack {
        Color(.accent).ignoresSafeArea()
        SectionsMenuView { _ in }
    }
}
