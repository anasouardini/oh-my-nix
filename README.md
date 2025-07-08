# oh my nix

## Usage:
Simply run this script and optionaly change "desktop" with one of the directories you see in the root of this repo.

Command: `bash <(curl -sL https://raw.githubusercontent.com/anasouardini/oh-my-nix/main/install.sh) desktop`

Short Verson: `bash <(curl -sL https://dozy.netlify.app/ohmynix.sh) desktop`

## Boring Details
The entry script accepts two arguments:
- one for the profile/machine which is a directory, that's how I decided to separate profiles/hosts/machines
- and the 2nd is for the actual configuration from the flake.nix configurations list, which is just the full installation split into two stages
  - 1st stage: simply installs a usable desktop which I can utilise while the system continues installing itself
  - 2nd stage: the rest of the installation, i.e. anything that's not necessary to have a working system

By default, if you don't specify the  2nd argument, it'll automatically assume that you're running the minimal configuration, which is what should happen, after which a systemd unit will automatically install the 2nd stage of the installaton (the "full" configuration) while you can still use the system.

So you don't have to provid the 2nd argument, but if you do, It'll work just fine, except that you won't benefit from using your system before the entire installaton is complete.
