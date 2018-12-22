#!/bin/bash

  ##################################
  #     Create symlinks to all     #
  # dotfiles in the home directory #
  ##################################

function delete_symlinks {
    for filename in $1; do
        if [[ -f ~/$filename || -L ~/$filename ]]; then
            echo "deleting old" $filename
            rm -f "~/$filename"
        fi
    done
}

for app in *; do
    if [ -d ${app} ]; then
        echo "linking " $app
        CONFLICTS=$(stow -nv "$app" 2>&1 | awk '/\* existing target is/ {print $NF}')
        delete_symlinks "$CONFLICTS"
        stow -R $app
    fi
done

# Do Xresource loading
xrdb ~/.Xresources

# get vim plugins
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

# do fonts
echo "Cloning fonts, goog & fira code"
FONT_GIT_DIR="/tmp/fonts"
FONT_DIR="$HOME/.fonts"
shopt -s globstar
mkdir -p $FONT_GIT_DIR $FONT_DIR
git clone git@github.com:Erik-J-D/FiraCode.git $FONT_GIT_DIR/fira
git clone git@github.com:Erik-J-D/fonts.git $FONT_GIT_DIR/goog
cp $FONT_GIT_DIR/**/*.ttf $FONT_DIR/
fc-cache -fv ~/.fonts
