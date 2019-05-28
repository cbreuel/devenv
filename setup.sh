#!/bin/bash

# Install tmux and tmx
sudo apt-get install tmux
curl -L https://raw.githubusercontent.com/arkku/dotfiles/master/bin/tmx -o ~/bin/tmx
chmod u+x ~/bin/tmx
cp ./.tmux.conf ~/.tmux.conf

# Install vim config and plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp .vimrc ~/.vimrc
vim +PluginInstall +qall

