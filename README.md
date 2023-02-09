# dotfiles
My emacs settings.

## Requirements
- Mac
- Emacs 27.1+
- Git2.23+

## Install
```
cd ~
git clone https://github.com/smjro/dotfiles.git
cd dotfiles
sh ~/dotfiles/deploy.sh
~/.emacs.d/bin/doom install
```

- `doom sync` to synchronize your private config with Doom by installing missing packages, removing orphaned packages, and regenerating caches. Run this whenever you modify your private init.el or packages.el, or install/remove an Emacs package through your OS package manager (e.g. mu4e or agda).
- `doom upgrade` to update Doom to the latest release & all installed packages.
- `doom doctor` to diagnose common issues with your system and config.
