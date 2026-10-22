# Declaration Ordering

## Purpose

Use this policy to order Swift declarations by visibility. Consistent ordering
makes the public interface easy to find. It also keeps implementation details
out of the public interface.

## Scope

Apply this policy to:

- Type declarations in a file, such as classes, structures, enumerations, and
  protocols.
- Members of a type, such as initializers, properties, and methods.
- Members declared in extensions.

## Order declarations by visibility

Put declarations with the most visible access level first. Use this order:

1. `open`
2. `public`
3. `package`
4. `internal`
5. `fileprivate`
6. `private`

Use the declared access level. Treat a declaration without an access modifier
as `internal`.

Do not put a less-visible declaration between declarations with a more-visible
access level. This rule is mandatory.

Do not write:

```swift
public func start() {}

private var observations = Set<AnyCancellable>()

public func stop() {}
```

Write:

```swift
public func start() {}
public func stop() {}

// MARK: - Private Properties

private var observations = Set<AnyCancellable>()
```

## Order members within one visibility level

Use this order by default:

1. Initializers.
2. Properties.
3. Methods.

Complete one visibility level before you start the next visibility level. For
example, put all `public` members before all `internal` members.

You can split one visibility level into multiple groups to keep related code
together. Add a descriptive `MARK` section for each related group. Within each
group, keep the default order of initializers, properties, and methods.

For example, an event observation property can stay near its observation
method:

```swift
// MARK: - Events

private var observations = Set<AnyCancellable>()

private func observeEvents() {
    observations.insert(eventEmitter.events.sink(receiveValue: handleEvent))
}
```

Do not use contextual grouping to put a less-visible declaration between
more-visible declarations.

## Mark private sections

Put private properties and private methods in separate sections by default.
Use these section names:

```swift
// MARK: - Private Properties

// MARK: - Private Methods
```

A descriptive `MARK` section can replace these default sections for a related
group. The descriptive section can contain properties and methods. All
declarations in the section must have the same visibility level.

Use descriptive `MARK` sections for other groups of related code when they make
the file easier to scan.

## Group constants in a `Constants` enumeration

If a type uses constant values, put them in a nested `Constants`
enumeration. Declare each constant as a `static let` member. Examples of
constant values are sizes, scales, durations, and identifiers.

Use an enumeration without cases. You cannot create an instance of it.

Give `Constants` the lowest access level that its users need. Usually this
level is `private`. Put `Constants` at the end of the type, in a
`// MARK: - Constants` section.

Do not write:

```swift
struct Orb: View {

    var body: some View {
        Circle()
            .frame(width: Self.diameter, height: Self.diameter)
    }

    // MARK: - Private Properties

    private static let diameter: CGFloat = 240
}
```

Write:

```swift
struct Orb: View {

    var body: some View {
        Circle()
            .frame(width: Constants.diameter, height: Constants.diameter)
    }

    // MARK: - Constants

    private enum Constants {

        /// The diameter of the orb.
        static let diameter: CGFloat = 240
    }
}
```

Do not put shared design values in `Constants`. Put colors, spacing, corner
radii, and other design tokens in the CoreUI foundations. For more information,
refer to [`Docs/DesignSystemStructure.md`](DesignSystemStructure.md).

## Declare file-scoped extension methods

Do not apply the `private` access modifier to an entire extension. Leave the
extension without an access modifier. Apply `fileprivate` to each file-scoped
method in the extension.

Do not write:

```swift
private extension Example {
    func updateState() {}
}
```

Write:

```swift
extension Example {
    fileprivate func updateState() {}
}
```

## Review checklist

Before you complete a Swift file, make sure that:

1. Declarations follow the visibility order.
2. A less-visible declaration does not interrupt a more-visible group.
3. Members in each section follow the default order.
4. Each related group has a descriptive `MARK`.
5. Separate private sections use the standard section names.
6. A file-scoped extension marks its methods `fileprivate` instead of marking
   the entire extension `private`.
7. Constant values are `static let` members of a nested `Constants`
   enumeration.
