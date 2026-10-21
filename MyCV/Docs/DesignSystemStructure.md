# Design System Structure

## Purpose

Use this policy to organize components in
`Packages/CoreUI/Sources/CoreUI/DesignSystem`. The structure must make
components easy to find. It must also show the composition level of each
component.

This policy adapts the Atomic Design Methodology to the project structure.

## Structure

The design system has five layers:

```text
DesignSystem/
├── Foundations/
├── Atoms/
├── Molecules/
├── Organisms/
└── Templates/
```

The layers move from abstract building blocks to concrete interface layouts:

```text
Foundations
    ↓
Atoms
    ↓
Molecules
    ↓
Organisms
    ↓
Templates
```

Use these layers as a mental model. Do not treat them as a strict dependency
graph or a linear implementation process. Classify a component by its purpose,
complexity, and role in the interface.

## Foundations

Foundations contain the basic values and visual primitives of the design
system. Examples include:

- Assets and colors.
- Borders and corner radii.
- Shadows and gradients.
- Spacing values.
- Typography definitions.

A foundation can depend on another foundation. It must not depend on an atom,
molecule, or organism.

Classify an item by its purpose. Do not classify an item as a foundation only
because it changes infrequently.

## Atoms

Atoms are the smallest reusable branded components. An atom can depend on:

- Foundations.
- Native SwiftUI or UIKit types.
- Low-level CoreUI utilities outside `DesignSystem`.

An atom must not depend on another atom, molecule, or organism.

Typical atom groups include:

```text
Atoms/
├── Buttons/
├── Indicators/
├── Inputs/
└── Pickers/
```

Add a group when it makes components easier to find. Do not add a group only
to contain one component.

## Molecules

Molecules are relatively simple groups of user-interface elements that
function together as a unit. A molecule gives its elements a clear purpose.

A molecule must have one clear responsibility. It should be portable,
reusable, and suitable for different presentation contexts.

A molecule usually combines atoms. It can reuse another molecule when the
result remains simple and focused. Its dependencies do not determine its
layer.

## Organisms

Organisms are relatively complex components that form distinct interface
sections. An organism can combine atoms, molecules, and other organisms.

An organism can use different component types. It can also repeat the same
component type. For example, a product collection can repeat one product-item
molecule.

Screen size does not determine the layer. A component is an organism because
it forms a distinct interface section, not because it fills a screen.

`ContentUnavailableView` is an organism. It coordinates content, controls,
scrolling, safe-area layout, and presentation state.

## Templates

Templates are screen-level objects that arrange components in a layout. A
template defines the underlying content structure. It does not define final
application content.

A template can arrange organisms, molecules, and atoms.

A reusable product-listing layout can become a template when it coordinates
the listing structure. This structure can include a header, filters, loading
and empty states, and a product collection. A product collection alone can be
an organism.

## Pages and the Application boundary

Atomic design uses pages as specific template instances that contain real
content. This project does not store pages in `DesignSystem`.

A screen view in the application target is the project equivalent of a page.
The view supplies application state, content, and actions. It can use a
template or compose design-system components directly.

Design-system components and templates must not own:

- Data loading.
- Navigation.
- Business workflows.

## Component placement

Use these steps when you add a component:

1. If the item is a token, asset, metric, or visual primitive, put it in
   `Foundations`.
2. If the component cannot be divided without losing its function, put it in
   `Atoms`.
3. If the component is a relatively simple and focused group of elements, put
   it in `Molecules`.
4. If the component is a relatively complex and distinct interface section,
   put it in `Organisms`.
5. If the object defines a screen-level layout and content structure, put it
   in `Templates`.
6. If the view supplies real application state, content, and actions, define
   it in the applicable screen folder of the application target.

Do not classify a component only from its dependencies. Reuse existing
components when the result keeps a clear purpose and responsibility.

## Component folders

Keep all files for one component family together. These files can include:

- The component implementation.
- Configuration types.
- Styles.
- Loading states.
- Localization resources.
- Component-specific assets.

Do not create subfolders that do not improve navigation. A small component can
keep its files directly in its component folder.

## Existing components

Apply these rules when you add or modify a component. Move existing components
incrementally after you review their responsibilities. Do not classify an
existing component from its name or visual size alone.
