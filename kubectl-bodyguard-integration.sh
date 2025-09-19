#!/bin/bash

# kubectl Bodyguard Shell Integration
# Add this to your ~/.bashrc, ~/.zshrc, or ~/.profile

# Path to the kubectl bodyguard script
if command -v kubectl-bodyguard.sh &> /dev/null; then
    KUBECTL_BODYGUARD_SCRIPT="kubectl-bodyguard.sh"
else
    echo "Warning: kubectl-bodyguard.sh not found!"
    echo "Please add it to your PATH by running:"
    echo "  export PATH=\"<path to>/kubectl_bodyguard:\$PATH\""
    echo "Or add this line to your ~/.bashrc or ~/.zshrc"
    KUBECTL_BODYGUARD_SCRIPT=""
fi

# Function to wrap kubectl and update colors after context changes
kubectl_wrapper() {
    command kubectl "$@"
    # Check if this was a context switch command
    if [[ "$1" == "config" && "$2" == "use-context" ]] && [[ -n "$KUBECTL_BODYGUARD_SCRIPT" ]]; then
        $KUBECTL_BODYGUARD_SCRIPT colors
    fi
}

# Override kubectl to trigger color updates
alias kubectl='kubectl_wrapper'

# Terminal color change on context switch (alternative method)
kubectl_context_switch() {
    command kubectl config use-context "$@"
    if [[ -n "$KUBECTL_BODYGUARD_SCRIPT" ]]; then
        $KUBECTL_BODYGUARD_SCRIPT colors
    fi
}

# Additional alias for explicit context switching
alias kubectl-use-context='kubectl_context_switch'

echo "🚨 kubectl bodyguard is watching - your terminal will warn you if you're about to break prod 🚨"

# Initialize colors on shell start
if command -v kubectl &> /dev/null && [[ -n "$KUBECTL_BODYGUARD_SCRIPT" ]]; then
    $KUBECTL_BODYGUARD_SCRIPT colors
fi
