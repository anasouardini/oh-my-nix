# oh my nix

## Usage:
Simply run this script and optionaly change "desktop" with one of the directories you see in the root of this repo.

Command:
```bash
bash <(curl -sL https://raw.githubusercontent.com/anasouardini/oh-my-nix/main/install.sh) desktop
```
Short Verson:
```bash
bash <(curl -sL https://dozy.netlify.app/ohmynix.sh) desktop
```

## Boring Details
The entry script accepts two arguments:
- one for the target machine which is a directory in the root of the repo (that's how I decided to separate machines installations).
- and the 2nd argmuent is for the actual configuration from the flake.nix configurations list, which is just the full installation split into two stages
  - 1st stage: simply installs a usable desktop and boots me into it, which I can utilise while the system continues installing itself
  - 2nd stage: the rest of the installation, i.e. anything that's not necessary to have a working system

By default, if you don't specify the  2nd argument, it'll automatically assume that you're running the 1st stage configuration, after which a systemd unit will automatically install the 2nd stage of the installaton (the "full" configuration) while you can still use the system.

You don't have to provid the 2nd argument for the script, but if you do, It'll work just fine, except that you won't benefit from using your system before the entire installaton is complete.
