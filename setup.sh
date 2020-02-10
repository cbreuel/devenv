#!/bin/bash

sudo apt-get install -y --no-install-recommends git
git clone https://github.com/cbreuel/devenv.git
cd devenv

cp -f .bash_aliases ~/.bash_aliases

# Install tmux and tmx
sudo apt-get install -y --no-install-recommends tmux
curl -L https://raw.githubusercontent.com/arkku/dotfiles/master/bin/tmx -o ~/bin/tmx
chmod u+x ~/bin/tmx
cp -f ./.tmux.conf ~/.tmux.conf

# Install vim config and plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp -f .vimrc ~/.vimrc
vim +PluginInstall +qall

# Install YouCompleteMe
sudo apt install -y --no-install-recommends build-essential cmake python3-dev
cd ~/.vim/bundle/YouCompleteMe/
./install.sh

