# Team rules for stacked and cascade PRs

You can stack PRs. Each PR must contain only changes that are related to its
description.

Rules:

* A PR must contain only changes that are related to its description.
* Do not merge changes from a downstream PR if the changes are not related to
  the upstream PR description.
* Reviewers must be able to review and understand each PR independently.
* If you stack PRs, you must maintain the stack. This work includes rebases and
  conflict resolution.

Results:

* These rules keep each review on one topic and make it easier to understand.
* These rules keep the Git history clean and make reverts possible.
* Clear PR boundaries help reviewers understand the changes in each PR.
* These rules make the codebase easier to maintain.

The team recommends squash merges and a linear history on `develop`. Because of
this method, it can be necessary to rebase a downstream PR after its parent PR
merges. The team knows that this rebase can be necessary.

Recommended workflow after the parent PR merges:

```bash
git fetch origin
git rebase --onto origin/develop <old-parent-branch> <your-branch>
```

This command applies the downstream PR commits directly to `origin/develop`.
It keeps the PR boundaries clean.

Other rules:

* If possible, do not use more than three levels in a stack.
* Do not keep stacks open for a long time.
* Always make the review easy to understand, even if this causes more work in
  the short term.
