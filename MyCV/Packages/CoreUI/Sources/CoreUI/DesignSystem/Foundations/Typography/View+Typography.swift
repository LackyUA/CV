//
//  View+Typography.swift
//  CoreUI
//

import OSLog
import SwiftUI

extension View {

    /// Applies a typography style to the view.
    ///
    /// - Important: Apply this modifier to leaf text views, not to containers. The modifier adjusts the
    ///   baseline of its content. If a container and its children share the modifier, the children get
    ///   extra padding and misaligned baselines.
    ///
    ///   Preferred usage:
    ///   ```swift
    ///   VStack {
    ///     Text("One")
    ///         .typography(.Interface.headline)
    ///     Text("Two")
    ///         .typography(.Interface.headline)
    ///   }
    ///   ```
    ///
    ///   Do not write:
    ///   ```swift
    ///   VStack {
    ///     Text("One")
    ///     Text("Two")
    ///   }
    ///   .typography(.Interface.headline)
    ///   ```
    @MainActor
    @ViewBuilder
    public func typography(_ typography: Typography, file: String = #fileID, line: UInt = #line) -> some View {
        let usageContext = TypographyPresenceKey.UsageContext(file: file, line: line)
        modifier(TypographyModifier(typography: typography, usageContext: usageContext))
    }
}

private struct TypographyModifier: ViewModifier {

    init(typography: Typography, usageContext: TypographyPresenceKey.UsageContext) {
        self.typography = typography
        self.usageContext = usageContext
        _multiplier = .init(wrappedValue: 1, relativeTo: typography.textStyle)
        shouldAdjustBaselineOffset = true
    }

    // MARK: - ViewModifier

    @ViewBuilder
    func body(content: Content) -> some View {
        let baselineOffset = baselineOffset
        content
            .font(resolvedFont)
            .environment(\._lineHeightMultiple, typography.lineHeightMultiple)
            .padding(
                .init(top: -baselineOffset, leading: 0, bottom: baselineOffset, trailing: 0)
            )
            .fontWeight(typography.swiftUiWeight)
            .tracking(typography.tracking * multiplier)
            .textCase(typography.isUppercased ? .uppercase : nil)
        #if DEBUG
            .onPreferenceChange(TypographyPresenceKey.self) { value in
                validateTypographyPresence(with: value)
                shouldAdjustBaselineOffset = value.isEmpty
            }
            .setTypographyPresent(context: usageContext)
        #endif // DEBUG
    }

    // MARK: - Private Properties

    private let typography: Typography, usageContext: TypographyPresenceKey.UsageContext

    @ScaledMetric
    private var multiplier: CGFloat

    @State
    private var shouldAdjustBaselineOffset: Bool

    private var resolvedFont: Font {
        Font(typography.font.withSize(typography.font.pointSize * multiplier))
    }

    private var baselineOffset: CGFloat {
        guard shouldAdjustBaselineOffset else {
            return 0
        }
        let lineHeight = typography.lineHeight * multiplier
        return lineHeight * (typography.lineHeightMultiple - 1) * 0.5
    }

    // MARK: - Logging

    private static let logger = Logger(coreUiCategory: "TypographyModifier")

    private func validateTypographyPresence(with value: TypographyPresenceKey.Value) {
        guard !value.isEmpty else {
            return
        }
        let applications = value.map { "\($0.file):\($0.line)" }.joined(separator: ", ")
        Self.logger.warning(
            """
            Typography already applied in child view. Skipping baseline adjustment to avoid layout issues. \
            Location: \(usageContext.file):\(usageContext.line). Applications: \(applications).
            """
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Text("Hello Test")
        .typography(.Interface.footnote)
        .padding()
}
