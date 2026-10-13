# dotfiles

My configs for Neovim (LazyVim), WezTerm, Starship, zsh and PowerShell,
managed with [chezmoi](https://www.chezmoi.io/) so they stay in sync across
macOS and Windows.

## What's in here

| Source (this repo)                                             | Installed to                    | OS            |
| -------------------------------------------------------------- | ------------------------------- | ------------- |
| `dot_config/nvim/`                                             | `~/.config/nvim/`               | all           |
| `dot_config/wezterm/wezterm.lua`                               | `~/.config/wezterm/wezterm.lua` | all           |
| `dot_config/starship.toml`                                     | `~/.config/starship.toml`       | all           |
| `dot_zshrc`                                                    | `~/.zshrc`                      | macOS / Linux |
| `Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1` | `$PROFILE`                      | Windows       |

`.chezmoiignore` controls which files go to which OS.

## Prerequisites

- Git, Neovim, WezTerm, Starship
- A [Nerd Font](https://www.nerdfonts.com/) set in WezTerm
- `ripgrep`, `fd`, a C compiler (for LazyVim)
- Node.js (Mason uses it for Prettier etc.). On macOS via `nvm`.
- macOS only: `zsh-autosuggestions` and `zsh-syntax-highlighting` (Homebrew)

## Set up a new Mac

1. Install chezmoi:

   ```sh
   # macOS 12 or newer:
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
   # macOS 11 Big Sur: newer releases won't run, pin the last compatible one:
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin -t v2.64.0
   ```

2. Set Git to use the GitHub no-reply email (pushes with a private email are blocked):

   ```sh
   git config --global user.email "55466213+mlau11@users.noreply.github.com"
   ```

3. Back up any existing configs (`~/.config/nvim`, `~/.zshrc`, etc.), then:

   ```sh
   ~/.local/bin/chezmoi init git@github.com:mlau11/dotfiles.git
   ~/.local/bin/chezmoi diff     # review what will change
   ~/.local/bin/chezmoi apply
   ```

4. Open a new terminal, start `nvim`, let plugins install, restart, then run
   `:Lazy restore` to match the pinned plugin versions in `lazy-lock.json`.

> On Big Sur, never run `chezmoi upgrade`. It installs a version that won't start.

## Set up Windows (read-only)

Windows only **pulls**. All edits are made and pushed from the Mac.

1. Install chezmoi: `winget install twpayne.chezmoi`

2. Make Neovim read its config from `~\.config` like the other tools:

   ```powershell
   [Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", "$env:USERPROFILE\.config", "User")
   Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak   # if it exists
   ```

   Fully close and reopen WezTerm.

3. Pull and apply (public repo over HTTPS, no login needed):

   ```powershell
   chezmoi init mlau11
   chezmoi diff
   chezmoi apply
   ```

4. In `nvim`: let plugins install, restart, then `:Lazy restore`.

> The PowerShell profile's `ListView` prediction needs PSReadLine 2.2+.
> Windows PowerShell 5.1 ships 2.0. The profile skips the setting if
> PSReadLine is older.

## Day-to-day

| Task                             | Command                                                                   |
| -------------------------------- | ------------------------------------------------------------------------- |
| Save edits made to a live config | `chezmoi re-add`                                                          |
| See what's out of sync           | `chezmoi status` / `chezmoi diff`                                         |
| Commit and push (Mac)            | `chezmoi cd` → `git add -A` → `git commit -m "..."` → `git push` → `exit` |
| Pull on another machine          | `chezmoi update`, then `:Lazy restore` in nvim                            |

After `:Lazy update`, run `chezmoi re-add` so the new `lazy-lock.json` is
saved. Update plugins on one machine only, and `:Lazy restore` on the rest.
