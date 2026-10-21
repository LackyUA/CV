#!/bin/bash

set -euo pipefail

# Navigate to project root
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
cd "$SCRIPT_DIR/.."

# Add brew binaries to PATH
export PATH="/opt/homebrew/bin:$PATH"

# Run SwiftGen
swiftgen
