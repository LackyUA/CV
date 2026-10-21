//
//  View+Scaled.swift
//  CoreUI
//

import SwiftUI

extension Image {

    /// Resizes the image relative to the text style. The image then adapts to Dynamic Type settings.
    @MainActor
    public func scaled(
        idealWidth: ScaledViewSize? = nil, idealHeight: ScaledViewSize? = nil, relativeTo textStyle: Font.TextStyle
    ) -> some View {
        ScaledView(content: self.resizable(), idealWidth: idealWidth, idealHeight: idealHeight, textStyle: textStyle)
    }
}

extension View {

    /// Resizes the view relative to the text style.
    @MainActor
    public func scaled(
        idealWidth: ScaledViewSize? = nil, idealHeight: ScaledViewSize? = nil, relativeTo textStyle: Font.TextStyle
    ) -> some View {
        ScaledView(content: self, idealWidth: idealWidth, idealHeight: idealHeight, textStyle: textStyle)
    }
}

private struct ScaledView<Content: View>: View {

    init(content: Content, idealWidth: ScaledViewSize?, idealHeight: ScaledViewSize?, textStyle: Font.TextStyle) {
        self.content = content
        self.idealWidth = idealWidth
        self.idealHeight = idealHeight
        self._scale = .init(wrappedValue: 1, relativeTo: textStyle)
    }

    // MARK: - View

    var body: some View {
        Group(subviews: content) { subviews in
            if !subviews.isEmpty {
                ScaledViewLayout(scale: scale) {
                    _UnaryViewAdaptor(subviews)
                        .scaledToFit()
                        .frame(idealWidth: idealWidth?.rawValue, idealHeight: idealHeight?.rawValue)
                }
            }
        }
    }

    // MARK: - Private Properties

    private let content: Content, idealWidth: ScaledViewSize?, idealHeight: ScaledViewSize?

    @ScaledMetric
    private var scale: CGFloat
}

private struct ScaledViewLayout: Layout {

    let scale: CGFloat

    // MARK: - Layout

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        guard !subviews.isEmpty else {
            return .zero
        }
        let contentView = subviews[0]
        let idealSize = contentView.sizeThatFits(.unspecified)
        guard scale != 1 else {
            return idealSize
        }
        let scale = if scale > 1 {
            min(maxScale(subview: contentView, idealSize: idealSize), scale)
        } else {
            max(minScale(subview: contentView, idealSize: idealSize), scale)
        }
        return CGSize(width: idealSize.width * scale, height: idealSize.height * scale)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        guard !subviews.isEmpty else {
            return
        }
        let contentView = subviews[0]
        let contentViewPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        contentView.place(at: contentViewPosition, anchor: .center, proposal: .init(bounds.size))
    }

    // MARK: - Private Methods

    private func minScale(subview: LayoutSubview, idealSize: CGSize) -> CGFloat {
        guard idealSize.width > 0, idealSize.height > 0 else {
            return 1
        }
        let minSize = subview.sizeThatFits(.zero)
        return max(minSize.width / idealSize.width, minSize.height / idealSize.height)
    }

    private func maxScale(subview: LayoutSubview, idealSize: CGSize) -> CGFloat {
        guard idealSize.width > 0, idealSize.height > 0 else {
            return 1
        }
        let maxSize = subview.sizeThatFits(.infinity)
        return min(maxSize.width / idealSize.width, maxSize.height / idealSize.height)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Label {
        Text(verbatim: "Description")
            .font(.body)
    } icon: {
        Image(systemName: "phone.fill")
            .scaled(idealHeight: ScaledViewSize(rawValue: 48), relativeTo: .body)
    }
    .foregroundStyle(Color.orange)
}
