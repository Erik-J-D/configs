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

### Audio interface stereo -> Mono

Get the name of the the device with
```
$ pacmd list-sources | grep -e 'index:' -e device.string -e 'name:'
```
Add the following to `/etc/pulse/default.pa`, swapping out the name after `master` for what you got:

```
load-module module-remap-source master=alsa_input.usb-Avid_Fast_Track_Solo_0217127E000C2400-00.analog-stereo channels=1 master_channel_map=front-left channel_map=mono source_properties="device.description='Avid Mic'"
load-module module-remap-source master=alsa_input.usb-Avid_Fast_Track_Solo_0217127E000C2400-00.analog-stereo channels=1 master_channel_map=front-right channel_map=mono source_properties="device.description='Avid Instrument'"
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
