# configs

## Installation

Install `git` and `stow`o

```
stow */
```

### Language servers

```
$ pip install 'python-lsp-server[all]' pyls-isort pylsp-mypy

$ GO111MODULE=on go get golang.org/x/tools/gopls@latest
    OR
$ go get -u golang.org/x/tools/...

$ raco pkg install racket-langserver

$ npm i -g vscode-langservers-extracted  # html and css
```

### caps -> ctrl

```
yay -S interception-tools interception-caps2esc
sudo cp ./udevmon/udevmon.yaml /etc/interception/udevmon.d/udevmon.yaml
sudo systemctl enable --now udevmon
```
