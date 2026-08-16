# dotfiles

My macOS config files, managed with GNU Stow. Every file here is the result of some real frustration that led to a configuration change — there's nothing that was set up "just in case."

## What's inside

| Directory   | Tool |
|-------------|------|
| `claude/`   | Claude Code CLI |
| `equibop/`  | Equicord Discord client |
| `flow/`     | Flow Control editor |
| `ghostty/`  | Ghostty terminal |
| `gitu/`     | Git UI |
| `nvim/`     | Neovim |
| `opencode/` | OpenCode |
| `pi/`       | Pi coding agent |

## Setup

```bash
git clone https://github.com/IzonIcy/DotFiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

If you only want certain ones:

```bash
stow nvim ghostty
```

To undo:

```bash
stow -D nvim
```

## Adding something

```bash
mkdir -p tmux/.config/tmux
cp ~/.config/tmux/tmux.conf tmux/.config/tmux/tmux.conf
stow tmux
```

The directory structure mirrors where the config lives relative to `$HOME`. Stow figures out the symlinks.

## Notes

- No secrets in here. API keys live in gitignored files like `.zshrc.local`.
- Tested on macOS. Most of it should work on Linux too.