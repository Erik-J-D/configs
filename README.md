# configs

## Installation

Install `git` and `stow`

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

$ rustup component add rls rust-analysis rust-src

$ npm install -g vim-language-server
```

### caps -> ctrl

Double check location of udevmon yaml file with `udevmon -h`

```
yay -S interception-tools interception-caps2esc
sudo cp ./udevmon/.udevmon.yaml /etc/interception/udevmon.d/udevmon.yaml
sudo systemctl enable --now udevmon
```

### MacOS BS

#### Make `Home` and `End` work:

```
$ mkdir -p ~/Library/KeyBindings/
$ vim ~/Library/KeyBindings/DefaultKeyBinding.dict

add the following:

{
    "\UF729"  = moveToBeginningOfLine:; // home
    "\UF72B"  = moveToEndOfLine:; // end
    "$\UF729" = moveToBeginningOfLineAndModifySelection:; // shift-home
    "$\UF72B" = moveToEndOfLineAndModifySelection:; // shift-end
}
```
