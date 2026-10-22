//
//  StartView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows the start screen for the current state of the view model.
///
/// In the initial state, the screen shows the welcome title and the start orb.
/// In the started state, the screen shows the sections menu.
/// The screen view animates the changes of the state and tells the view model when an animation completes.
struct StartView: View {

    init(viewModel: StartViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        ZStack {
            Colors.bg100.swiftUIColor
                .ignoresSafeArea()

            switch viewModel.state {
            case .idle:
                EmptyView()
            case .initial(let currentState):
                StartInitialView(configuration: currentState.configuration)
            case .started(let currentState):
                StartStartedView(configuration: currentState.configuration)
            }
        }
        .animation(Constants.stateAnimation, value: viewModel.state.layoutAnimationIdentity) {
            viewModel.finishStart()
        }
        .onAppear {
            viewModel.initiate()
        }
        // The landing screen has no bar, so pushed screens get a plain "Back" button.
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Private Properties

    @State
    private var viewModel: StartViewModel

    // MARK: - Constants

    private enum Constants {

        /// The animation of a state change, such as the expansion of the start orb.
        static let stateAnimation: Animation = .easeInOut(duration: 0.5)
    }
}

#Preview {
    StartView(viewModel: StartViewModel(router: RootRouter()))
}
