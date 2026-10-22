//
//  View+AnimationCompletion.swift
//  CoreUI
//

import SwiftUI

extension View {

    /// Applies an animation to this view when a value changes, and calls a closure when the animation completes.
    ///
    /// Use this modifier to animate a change of state that a view model makes without `withAnimation`.
    /// The modifier calls `completion` only after a change of `value`.
    ///
    /// ```swift
    /// content
    ///     .animation(.easeInOut, value: viewModel.state.layoutAnimationIdentity) {
    ///         viewModel.finishStart()
    ///     }
    /// ```
    ///
    /// - Parameters:
    ///   - animation: The animation to apply. If `animation` is `nil`, the view does not animate.
    ///   - value: A value to monitor for changes.
    ///   - completion: A closure that the modifier calls when the animation completes.
    public func animation<V: Equatable>(
        _ animation: Animation?, value: V, completion: @escaping @MainActor () -> Void
    ) -> some View {
        transaction(value: value) { transaction in
            transaction.animation = animation
            transaction.addAnimationCompletion {
                MainActor.assumeIsolated {
                    completion()
                }
            }
        }
    }
}
