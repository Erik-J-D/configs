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

# pip install 'python-lsp-server[all]' pyls-isort pylsp-mypy

# GO111MODULE=on go get golang.org/x/tools/gopls@latest
# OR
# go get -u golang.org/x/tools/...

# npm install -g typescript typescript-language-server
