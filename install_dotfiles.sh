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

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
cd $dir
for file in *; do
    mv ~/.$file $olddir/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# Do Xresource loading
xrdb ~/.Xresources

# get pathogen and vim plugins
if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
    mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi
URLS="
https://github.com/ctrlpvim/ctrlp.vim
https://github.com/scrooloose/nerdcommenter
https://github.com/morhetz/gruvbox.git
https://github.com/sheerun/vim-polyglot.git
https://github.com/vim-syntastic/syntastic.git
https://github.com/mtscout6/syntastic-local-eslint.vim.git
https://github.com/prettier/vim-prettier.git
"
for URL in $URLS; do
    IFS=/; read -a URLDIRTMP <<<"$URL"; IFS=.; read -a URLDIR <<< "${URLDIRTMP[-1]}"; unset IFS
    if [ -d ~/.vim/bundle/$URLDIR ]; then
        cd ~/.vim/bundle/$URLDIR && git pull
    else
        git clone $URL ~/.vim/bundle/$URLDIR
    fi
done
