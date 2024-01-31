#!/usr/bin/bash

set -e

mkdir ~/.config
if [[ `lsb_release -is` = "ManjaroLinux" ]]; then
    sudo pamac install --no-confirm stow
elif [[ `lsb_release -is` = "Ubuntu" ]]; then
    sudo aptitude update
    sudo apt install -y aptitude
    sudo aptitude install -y stow
fi

# nvim
if true; then
    if [[ `lsb_release -is` = "ManjaroLinux" ]]; then
        sudo pamac install --no-confirm neovim
    elif [[ `lsb_release -is` = "Ubuntu" ]]; then
        sudo add-apt-repository ppa:neovim-ppa/unstable -y
        sudo aptitude update
        sudo aptitude install -y neovim
    fi
    git submodule init
    git submodule update
    stow nvim
fi

# shell
if true; then
    stow shell
    if [[ `lsb_release -is` = "ManjaroLinux" ]]; then
        sudo pamac install --no-confirm zsh
    elif [[ `lsb_release -is` = "Ubuntu" ]]; then
        sudo aptitude update
        sudo aptitude install -y zsh
    fi
    sudo chsh $USER --shell=/usr/bin/zsh
    zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM}/plugins/zsh-completions
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# git
if true; then
    stow git
fi
