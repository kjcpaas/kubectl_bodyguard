# kubectl Bodyguard

Your personal bodyguard that protects you from accidentally breaking production Kubernetes clusters.

## Installation

1. Clone or download this repository
2. Add the warning script to your PATH
3. Source the shell integration script

### Adding to PATH

Add the kubectl bodyguard directory to your PATH so the script can be found from anywhere:

```bash
# Add to your ~/.bashrc or ~/.zshrc
export PATH="/path/to/kubectl_bodyguard:$PATH"
```

Replace `/path/to/kubectl_bodyguard` with the actual path to this directory.

### Shell Integration

**Important:** Add the bodyguard integration to your shell configuration AFTER adding the PATH export above:

```bash
# For Bash users, add to ~/.bashrc:
export PATH="/path/to/kubectl_bodyguard:$PATH"
source /path/to/kubectl_bodyguard/kubectl-bodyguard-integration.sh

# For Zsh users, add to ~/.zshrc:
export PATH="/path/to/kubectl_bodyguard:$PATH"
source /path/to/kubectl_bodyguard/kubectl-bodyguard-integration.sh
```

## Usage

Once installed, kubectl bodyguard provides:

- **kubectl-use-context** - Switch context with automatic visual feedback
- **Automatic terminal background changes** when in production contexts

## Features

- Terminal background changes to warn when you're in production contexts
- Automatic detection of production environments
- Visual warning messages when entering production
- Protects you from accidentally breaking prod

## Troubleshooting

If you see "kubectl-bodyguard.sh not found" errors, ensure:

1. The script is executable: `chmod +x kubectl-bodyguard.sh`
2. The directory is in your PATH as described above
3. You've reloaded your shell or sourced your configuration file

## Files

- `kubectl-bodyguard.sh` - Main bodyguard script
- `kubectl-bodyguard-integration.sh` - Shell integration functions
- `setup-kubectl-warnings.sh` - Setup helper script