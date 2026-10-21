#!/bin/bash

set -euo pipefail

# Add brew binaries to PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Run SwiftLint without rules that require SourceKit to workaround Xcode Cloud issue.
if [ "${CI_XCODE_CLOUD:-}" == "TRUE" ]; then
  export SWIFTLINT_DISABLE_SOURCEKIT=1
fi

# Navigate to project root
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
cd "$SCRIPT_DIR/../.."

# Run Swiftlint
swiftlint lint --strict
