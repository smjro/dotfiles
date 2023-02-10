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

### Install ptvsd
PTVSD(Python Tools for Visual Studio debug sever) is the debugger that is based on the Debug Adapter Protocol for VS Code.
```
pip install ptvsd
```

### Install ChatGPT
- Press C-c g to query ChatGPT.
- Select region, then C-c g will prompt you to select a type: doc, bug, understand, or improve. Select a type to query ChatGPT with that prompt.
- Try making queries in quick succession.
- If your login is expired, try
```
pkill ms-playwright/firefox
chatgpt install
```
in the shell.
- To reset your conversation, try M-x chatgpt-reset.
```
pip install epc
pip install git+https://github.com/mmabrouk/chatgpt-wrapper
chatgpt install
```
