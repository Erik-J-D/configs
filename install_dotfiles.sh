#!/bin/bash

  ##################################
  #     Create symlinks to all     #
  # dotfiles in the home directory #
  ##################################

dir=~/configs/dotfiles     # dotfiles directory
olddir=~/configs_old       # old dotfiles backup directory

# create configs_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

cd $dir
# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in *; do
    mv ~/.$file $olddir/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# get pathogen and vim plugins
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go
git clone https://github.com/ctrlpvim/ctrlp.vim ~/.vim/bundle/ctrlp
