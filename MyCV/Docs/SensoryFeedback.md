# Sensory Feedback

## Overview

Sensory feedback (haptics) is part of the user interface. Only the presentation
layer can give sensory feedback.

Use SwiftUI's `sensoryFeedback` modifier to give sensory feedback. If this
method is not applicable, a view model can use `UIFeedbackGenerator` subclasses
directly.

Code in services, repositories, storage, and all other non-UI layers must not
give sensory feedback.

## Recommended method: SwiftUI `sensoryFeedback`

Use the `sensoryFeedback` modifier when the view state contains the feedback
trigger. You can also use it when the view state can supply the trigger without
more complexity.

This method keeps sensory feedback declarative. It also keeps the feedback in
the UI that the user uses.

## Alternative method: `UIFeedbackGenerator` in a view model

If state that only triggers `sensoryFeedback` adds complexity that is not
necessary, a view model can use `UIFeedbackGenerator` subclasses directly.

You can use this method when the feedback has a direct relation to presentation
logic. Use it when a declarative trigger does not make the architecture better.
