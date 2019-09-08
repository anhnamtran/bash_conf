# Dot and Configuration Files

## Installation
```
curl https://raw.githubusercontent.com/anhnamtran/bash_conf/master/configure -o configure
chmod +x configure
```

Variables:
- `CONFIGS_ROOT`: where the dotfiles and configs will be installed.
- `CONFIGS_BACKUP_DIR`: where the previous dotfiles and configs will moved to.
- `CONFIGS_GIT_DIR`: name of the directory Git will use to track files.
- `CONFIGS_GIT_BRANCH_NAME`: name of the branch for the specific machine's
  configs.
- `CONFIGS_INSTALL_PACKAGES`: whether or not to install native packages.
- `CONFIGS_INSTALL_AUR`: whether or not to install AUR packages (for Arch).
- `CONFIGS_INSTALL_CONFIGS`: whether or not to install `.config` directories.
- `CONFIGS_INSTALL_DOT_FILES`: whether or not to install `.*` files.
- `CONFIGS_INSTALL_THEMES`: whether or not to install `.themes` directories.
- `CONFIGS_REMOTE`: the remote Git repository to pull from.
  - The repository must have the following structure:
  ```
  ./
  |__bin/
  |  |__...
  |__configs/
  |  |__vim/
  |  |  |__...
  |  |__i3/
  |  |  |__...
  |  |__...
  |__dotfiles/
  |  |__bashrc
  |  |__profile
  |  |__...
  |__themes/
  |  |__theme_1/
  |  |  |__...
  |  |__...
  |__nat-pac-list
  |__aur-pac-list
  ```

## Usage
```
./configure COMMAND [file]
Commands:
  show      Show the current variables that are used for installation.
  install   Start the installation process.
  file      The script will source this file before running any commands.
```

To change the variables in bulk, run:
```
./configure show > myvars.bash
```
And change the values in that file, then run:
```
./configure install myvars.bash
```
