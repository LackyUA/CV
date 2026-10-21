# Technical Writing Style

## Purpose

Use this policy to make technical information clear and consistent.

Technical writing in this repository must use the writing principles of
[ASD-STE100 Simplified Technical English][ste-home]. The controlled dictionary
in ASD-STE100 is not required. Thus, do not describe project content as fully
compliant with ASD-STE100.

For the complete standard, refer to
[ASD-STE100 Simplified Technical English, Issue 9][ste-standard].

## Scope

Apply this policy to all technical writing in the repository. This content
includes:

- Markdown documentation, such as files in `Docs/` and `README.md` files.
- Repository instructions, such as `AGENTS.md` and `CLAUDE.md`.
- Skill instructions and references in `.agents/skills/` and `.claude/skills/`.
- Swift documentation comments that use `///` or `/** ... */`.

Do not change these types of content to obey this policy:

- Code identifiers and function signatures.
- Commands and code examples.
- Literal error messages and user-interface text.
- Text from an external source.
- Third-party files.
- Code comments that are not documentation comments.

## Writing rules

### Use short and direct sentences

- Write one topic in each sentence.
- Write one instruction in each sentence. You can put two actions in one
  sentence only when they occur at the same time.
- Divide a long sentence into two or more short sentences.
- Put a condition before an instruction when the reader must know the
  condition first.

### Use active voice

Use active voice when you know the person or object that does the action.

Use the imperative form for instructions:

```text
Run the test suite.
```

Do not use passive voice for an instruction:

```text
The test suite must be run.
```

You can use passive voice when the actor is unknown or is not important.

### Use consistent terminology

- Use one term for one concept.
- Use a word with the same meaning each time.
- Do not use different words only to add variety.
- Use project-specific technical terms when they are necessary.
- Preserve the spelling and capitalization of code identifiers.

### Prevent ambiguity

- Make sure that it is clear what each pronoun refers to.
- Define an abbreviation the first time that you use it.
- Avoid long groups of nouns.
- State requirements with `must`.
- State prohibited actions with `must not` or `do not`.
- State recommendations with `should`.

### Organize the information

- Give each section one purpose.
- Use a list for a group of rules, options, or steps.
- Put steps in the order in which the reader must do them.
- Put the most important information first.
- Remove information that does not help the reader complete the task.

## Examples

### Markdown

Do not write:

> When this module is modified, the relevant checks should be run and their
> results should then be reviewed before the change can be considered ready.

Write:

> If you modify this module, run the relevant checks. Review the results before
> you complete the change.

### Swift documentation

Do not write:

```swift
/// This function is responsible for the creation of an order and the return
/// of the identifier associated with the newly created order.
```

Write:

```swift
/// Creates an order and returns its identifier.
```

## Review checklist

Before you complete technical writing, make sure that:

1. Each sentence has one clear topic.
2. Instructions use active and direct language.
3. The same term identifies the same concept.
4. Pronouns and conditions are not ambiguous.
5. Lists and steps have a logical order.
6. Code identifiers and literal text did not change.

[ste-home]: https://www.asd-ste100.org/
[ste-standard]: https://www.asd-ste100.org/assets/files/ASD-STE100_ISSUE9.pdf
