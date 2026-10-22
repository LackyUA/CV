# Screen Architecture

## Purpose

Use this policy to divide a screen into a view model, a state, configurations,
and views. The division keeps the data of a screen separate from its
presentation. You can test a view model without SwiftUI. You can preview a
view with literal data.

## Scope

Apply this policy to screens in the Application package, in
`Packages/Application/Sources/Application/Screens/`.
Apply it to new screens and to screens that you change. Move existing screens
incrementally.

Do not apply this policy to design-system components in CoreUI. For those
components, refer to
[`Docs/DesignSystemStructure.md`](DesignSystemStructure.md).

## Structure

A screen folder contains a `View` folder and a `ViewModel` folder:

```text
Screens/Start/
├── View/
│   ├── StartView.swift
│   ├── Initial/
│   │   ├── StartInitialView.swift
│   │   ├── StartInitialViewConfiguration.swift
│   │   └── Title/
│   │       ├── StartInitialTitleView.swift
│   │       └── StartInitialTitleViewConfiguration.swift
│   └── Started/
│       ├── StartStartedView.swift
│       ├── StartStartedViewConfiguration.swift
│       └── ...
└── ViewModel/
    ├── StartViewModel.swift
    └── StartViewModelState.swift
```

Put each subview in its own folder with its configuration. Nest the folders
in the same way as the views. Name a configuration after its view with the
`Configuration` suffix. For example, `StartInitialTitleView` has
`StartInitialTitleViewConfiguration`.

## Roles

### View model

The view model owns the state of the screen and handles its actions. The
view model must:

- Build a configuration for each view that shows data.
- Resolve text into `String` values.
- Resolve images into `Image` values.
- Build the actions of each configuration.
- Update the state when an action occurs.
- Navigate through a router.

An action that calls the view model must capture `self` weakly, for example
`{ [weak self] in self?.start() }`. The action must read the current state
from the view model when it runs. It must not capture a value that can change,
because a view can keep an older action. For more information, refer to
[Actions](#actions).

Build the actions in an instance method, not in a `static` method.

#### Initiation

A closure cannot capture `self` before the initializer sets all stored
properties. Thus, the initializer must not build a configuration with
actions. The initializer sets the state to `idle`. The `initiate()` method
sets the first state with configurations:

```swift
init(router: any Router<RootRouter.Route>) {
    self.router = router
    state = .idle
}

func initiate() {
    guard case .idle = state else {
        return
    }
    state = .initial(.init(configuration: initialConfiguration(isStarting: false)))
}
```

The screen view calls `initiate()` in `onAppear`. A screen can appear more
than one time, for example when the user goes back to it. Thus,
`initiate()` must have an effect only in the `idle` state.

#### Animation

The view model must not animate. It must not call `withAnimation` or put
an `Animation` value in its state. It changes the state, and the screen
view animates the change. For more information, refer to
[Animation of state changes](#animation-of-state-changes).

If the view model must continue after an animation, give it a method that
the screen view calls when the animation completes, such as
`finishStart()`. The method must check the current state, because the
screen view can call it more than one time.

The view model must not build views or view modifiers. It must not select
colors, fonts, spacing, shadows, or other design tokens.

### State

The state is an enumeration with one case for each mode of the screen. Each
case carries the configuration of the view for that mode. The state must be
`Equatable`.

The first case is `idle`. In the `idle` state, the view model has not
initiated the screen, and the screen view shows only its background. The
`idle` case has no data.

#### Animation of state changes

The state conforms to `AnimationIdentityProvider` from CoreUI. Its
`layoutAnimationIdentity` property contains only the values that a state
change must animate. A state change that keeps the same identity does not
animate.

```swift
extension StartViewModelState: AnimationIdentityProvider {

    var layoutAnimationIdentity: AnyHashable {
        switch self {
        case .idle:
            false
        case .initial(let currentState):
            currentState.configuration.isStarting
        case .started:
            true
        }
    }
}
```

The screen view animates a change of the identity. If the view model must
continue after the animation, use the CoreUI `animation(_:value:completion:)`
modifier:

```swift
.animation(Constants.stateAnimation, value: viewModel.state.layoutAnimationIdentity) {
    viewModel.finishStart()
}
```

If no step follows the animation, use the SwiftUI `animation(_:value:)`
modifier.

### Configuration

A configuration is a structure that holds the data that a view shows. It
must be `Equatable`.

A configuration can contain:

- `String` values.
- `Image` values.
- `Bool`, numeric, and other plain values.
- Identifiers of the `UniqueIdentifier` type.
- Actions marked with `@NullEquatable`.
- Other configurations.
- Arrays of these values.

A configuration must not contain:

- `LocalizedStringResource` or `LocalizedStringKey`. Resolve text into a
  `String` in the view model. If the text is localized, call
  `String(localized:)` in the view model.
- `ImageAsset`, asset names, or other references that a view must resolve.
  Resolve images into an `Image` in the view model.
- Colors, fonts, typography styles, spacing, shadows, or other design tokens.
- Views other than `Image`, view modifiers, or view builders.
- Closures that are not marked with `@NullEquatable`.
- Raw identifiers, such as a `String`, an `Int`, a `UUID`, or a model value.
  Wrap an identifier in `UniqueIdentifier`.

#### Identifiers

Use `UniqueIdentifier` from the Core package for the identifier of an item in
a configuration. Give the item type as the first generic argument. Give the
raw value type as the second generic argument. The item type makes the
identifier type-safe. The compiler rejects an identifier of a different item.

```swift
import Core

struct StartStartedSectionsViewConfiguration: Equatable {

    struct Section: Equatable, Identifiable {

        /// The identifier of the button. The raw value is the position of the section in the CV.
        let id: UniqueIdentifier<Self, Int>

        /// The title of the button.
        let title: String
    }

    /// The section buttons, from top to bottom.
    let sections: [Section]
}
```

Use the identifier for `ForEach` and other identity. Do not use the identifier
to select an action in the view. Put the action in the configuration.

#### Actions

Put each action of a view in its configuration as a closure. Mark the closure
with the `@NullEquatable` property wrapper from the Core package. Declare it
with `var`, because a property wrapper requires `var`.

`@NullEquatable` makes all values of the closure equal. Thus, the
configuration stays `Equatable`, and an action does not cause an update of
the view. Two configurations that differ only in their actions are equal.
SwiftUI can then keep the older action. For this reason, an action must call
the view model and must not capture data that can change.

```swift
import Core

struct StartInitialViewConfiguration: Equatable {

    /// The title of the start orb.
    let startButtonTitle: String

    /// A Boolean value that indicates whether the start orb expands.
    let isStarting: Bool

    /// Starts the screen.
    @NullEquatable
    var start: () -> Void
}
```

`Image` is allowed because it is an `Equatable` value. It describes an image.
It does not render until a view uses it. Create an `Image` from a CoreUI
asset. If the image is decorative, use `Image(decorative:)`, such as
`Image(decorative: Images.profileImage)`. Assistive technologies then ignore
the image. If the image gives information, use `Image(asset:label:)` with a
label. Do not use `swiftUIImage`, because it gives the image no
accessibility decision. Do not create an `Image` from a `UIImage` for a
configuration. Two `Image` values from different `UIImage` instances can be
unequal when the images look the same.

### View

A view renders a configuration. The view must:

- Take a configuration as a `let` property.
- Call the actions of its configuration, such as `configuration.start()`.
- Define layout, typography, colors, shadows, and animation.
- Use design tokens and components from CoreUI.

A view must not read a model, a service, or a resource directly. It must not
load a localized string or an asset. It gets all strings and images from its
configuration. It must not contain business logic. It can hold presentation
state in `@State`, such as a flag for a presentation animation. A view must
not take an action as a separate closure parameter. It gets all actions from
its configuration.

The screen view, such as `StartView`, is the only view that holds the view
model. The screen view must:

- Switch over the state and pass each configuration to the view for that
  case.
- Show only its background in the `idle` state.
- Call `initiate()` in `onAppear`.
- Animate the state changes. For more information, refer to
  [Animation of state changes](#animation-of-state-changes).

The screen view can call view model methods for these events only: the
appearance of the screen and the completion of an animation. It gets all
other actions from the configurations. A subview must not know the view
model.

For constants in a view, refer to
[`Docs/DeclarationOrdering.md`](DeclarationOrdering.md).

## Previews

Give each view a `#Preview` that creates its configuration with literal
values. Only the preview of the screen view creates a view model.

## Example

The configuration holds the data and the action:

```swift
import Core

struct StartInitialViewConfiguration: Equatable {

    /// The configuration of the welcome title.
    let title: StartInitialTitleViewConfiguration

    /// The title of the start orb.
    let startButtonTitle: String

    /// A Boolean value that indicates whether the start orb expands.
    let isStarting: Bool

    /// Starts the screen.
    @NullEquatable
    var start: () -> Void
}
```

The view model builds the configuration and its action:

```swift
private func initialConfiguration(isStarting: Bool) -> StartInitialViewConfiguration {
    .init(
        title: .init(kicker: "Welcome to", title: "My CV"),
        startButtonTitle: "Start",
        isStarting: isStarting,
        start: { [weak self] in
            self?.start()
        }
    )
}
```

The view renders the configuration and calls the action:

```swift
struct StartInitialView: View {

    let configuration: StartInitialViewConfiguration

    var body: some View {
        VStack(spacing: Spacing.xl) {
            StartInitialTitleView(configuration: configuration.title)

            Button(configuration.startButtonTitle) {
                configuration.start()
            }
            .buttonStyle(.startOrb)
            .startOrbButtonExpanded(configuration.isStarting)
        }
    }
}
```

## Review checklist

Before you complete a screen, make sure that:

1. Each view that shows data has a configuration with the `Configuration`
   suffix.
2. Each configuration and the state are `Equatable`.
3. Configurations contain `String` and `Image` values, not resources, asset
   names, or design tokens.
4. Configurations use `UniqueIdentifier` for identifiers.
5. Configurations contain actions marked with `@NullEquatable`. Views do not
   take actions as separate closure parameters.
6. Each action captures the view model weakly and does not capture data that
   can change.
7. The view model builds every configuration and resolves every string and
   image.
8. Views do not read models, services, strings, or assets directly.
9. Only the screen view holds the view model.
10. The state starts in `idle`, and `initiate()` sets the first state with
    configurations. `initiate()` has an effect only in the `idle` state.
11. The view model does not call `withAnimation`. The state conforms to
    `AnimationIdentityProvider`, and the screen view animates changes of
    `layoutAnimationIdentity`.
12. Each view has a preview with literal configuration values.
