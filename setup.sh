#!/bin/bash
# Setup script for foundation dotfiles
# Creates symlink: ~/.zshrc → foundation/zsh/.zshrc

set -euo pipefail

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() {
    echo -e "${GREEN}✓${NC} $1"
}

warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1" >&2
}

# Check if zsh directory exists
if [[ ! -d "$REPO_ROOT/zsh" ]]; then
    error "zsh directory not found in $REPO_ROOT"
    exit 1
fi

if [[ ! -f "$REPO_ROOT/zsh/.zshrc" ]]; then
    error "zsh/.zshrc not found in repository"
    exit 1
fi

# Function to create symlink with backup if needed
create_symlink() {
    local target="$1"
    local link_path="$2"
    local link_name="$(basename "$link_path")"
    
    if [[ -e "$link_path" ]] || [[ -L "$link_path" ]]; then
        if [[ -L "$link_path" ]]; then
            local current_target="$(readlink "$link_path")"
            if [[ "$current_target" == "$target" ]]; then
                info "$link_name already points to the correct location"
                return 0
            else
                warn "$link_name exists as a symlink pointing to: $current_target"
            fi
        else
            warn "$link_name already exists (not a symlink)"
        fi
        
        local backup="${link_path}.backup.$(date +%Y%m%d_%H%M%S)"
        warn "Backing up existing $link_name to $backup"
        mv "$link_path" "$backup"
    fi
    
    # Create parent directory if needed
    local parent_dir="$(dirname "$link_path")"
    if [[ ! -d "$parent_dir" ]]; then
        mkdir -p "$parent_dir"
        info "Created directory: $parent_dir"
    fi
    
    # Create symlink
    ln -s "$target" "$link_path"
    info "Created symlink: $link_name → $target"
}

# Create symlink
info "Setting up symlink..."

# ~/.zshrc → foundation/zsh/.zshrc
create_symlink "$REPO_ROOT/zsh/.zshrc" "$HOME/.zshrc"

info "Setup complete!"
info "You may need to restart your shell or run: source ~/.zshrc"
