//
//  StartFailedViewConfiguration.swift
//  MyCV
//

import Core

struct StartFailedViewConfiguration: Equatable {

    /// The message that tells the user that the CV did not load.
    let message: String

    /// The title of the button that loads the CV again.
    let retryButtonTitle: String

    /// Loads the CV again.
    @NullEquatable
    var retry: () -> Void
}
