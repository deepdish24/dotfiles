# Notes

## TODOs

- [ ] Add prereq installation to `install.sh` (see options below)
- [ ] Test `install.sh` on a fresh macOS machine
- [ ] Test `install.sh` on a fresh Ubuntu machine
## Prereq Installation Options

The install script currently assumes prereqs (git, zsh, vim, neovim, tmux, curl) are already installed. Here are options for automating that:

### Option 1: Detect OS via `uname` + `/etc/os-release`

Use `uname -s` to distinguish macOS vs Linux, then parse `/etc/os-release` on Linux to determine the distro. Branch into the right package manager:

- macOS -> `brew install`
- Ubuntu/Debian -> `apt-get install`
- Fedora -> `dnf install`
- Arch -> `pacman -S`

Pros: Explicit, easy to understand.
Cons: Grows with every distro you want to support.

### Option 2: Detect package manager directly

Check which package manager exists (`command -v brew`, `command -v apt-get`, etc.) instead of detecting the OS. More resilient since some distros have multiple options or non-standard setups.

Pros: Fewer branches, works on derivative distros automatically.
Cons: Less explicit about what OS you're targeting.

### Option 3: Separate scripts per OS

Split into `install-macos.sh`, `install-ubuntu.sh`, etc. with a top-level `install.sh` that detects the OS and calls the right one.

Pros: Each script is simple and focused.
Cons: More files, shared logic gets duplicated or needs to be factored out.

### Option 4: Makefile with targets

Use `make install-macos`, `make install-ubuntu`, or `make install` with auto-detection.

Pros: Familiar pattern, easy to add new targets.
Cons: Adds a Makefile dependency, less portable than a bash script.

### Note on Neovim

Neovim needs special handling on Ubuntu regardless of approach since `apt` ships an outdated version. Options: install from GitHub releases (current Dockerfile approach), use the Neovim PPA, or use snap/flatpak.
