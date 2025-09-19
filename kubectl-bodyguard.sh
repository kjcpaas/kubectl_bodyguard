#!/bin/bash

# kubectl Bodyguard - Protects you from breaking prod

# Configuration - can be overridden in ~/.kubectl-bodyguard-config
PROD_BG_COLOR="#4d2f1a"  # Default dark brown
PROD_PATTERNS=(
    "prod"
    ".*-prod.*"
    ".*-production.*"
)

# Load user configuration if it exists
if [[ -f ~/.kubectl-bodyguard-config ]]; then
    source ~/.kubectl-bodyguard-config
fi

# Function to check if current context is production
is_production_context() {
    local current_context=$(kubectl config current-context 2>/dev/null)

    # Use configurable production context patterns
    for pattern in "${PROD_PATTERNS[@]}"; do
        if [[ $current_context =~ $pattern ]]; then
            return 0  # true - is production
        fi
    done

    return 1  # false - not production
}

# Function to set terminal background color
set_terminal_color() {
    if is_production_context; then
        # Set terminal background to red for production
        printf "\033]11;${PROD_BG_COLOR}\007"  # Configurable production background
        # Show warning message when switching to prod
        local current_context=$(kubectl config current-context 2>/dev/null)
        echo -e "\033[1;37m⚠️  PRODUCTION CONTEXT: $current_context"
        echo -e "Please be extra careful with your commands!\033[0m"
        echo
    else
        # Reset to default terminal background
        printf '\033]111;\007'
        # Show safe mode message when switching away from prod
        local current_context=$(kubectl config current-context 2>/dev/null)
        echo -e "\033[0;32m✅ You're safe from breaking prod! Currently in: $current_context\033[0m"
        echo
    fi
}

# Main execution
case "$1" in
    "color"|"colors"|"")
        set_terminal_color
        ;;
    *)
        echo "Usage: $0 [color]"
        echo "kubectl Bodyguard - Changes terminal background when in production kubectl context"
        ;;
esac
