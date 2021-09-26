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
```
