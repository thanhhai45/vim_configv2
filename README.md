# Welcome to Everybody 
- This is my Vim config, particular is Neovim.
- In this version. I was build vim with Lua Programming Language.
- It's difficult and you will enjoy that.

# Step setup your device

## Firstly: You need install packer. The packer is library control all package of my config. It like the same Vim-Plug if you know.
- Link install: https://github.com/wbthomason/packer.nvim.
- The packer install very easy.

## Secondly: You need install neovim
- The MacOS install by homebrew: ```brew install neovim```
- The linux ubuntu install by apt: ```sudo apt-get neovim```

  ### Small step in step second.
    - Ruby: ```gem install neovim```
    - Python 3: ```pip3 install neovim```
    - Nodejs: ```npm install -g neovim```

## Finally step
- Open neovim on terminal with command: ```nvim``` 
- Next enter on keyboard if show notification.

  ### Install package with packer.
    - Enter ESC on your keyboard and enter command: ```:PackerInstall``` . Then ```:PackerSync```
  
  ### Install plugins.
    - Enter ESC on your keyboard and enter command: ```:LspInstall``` . Then choose plugin you want and enter.

  ### You want know keymap on my config
    - Enter ESC on your keyboard and enter command: ```:WhichKey``` . Follow that.

## My keymap config
- Find file: ```,ff```
- Find text: ```,fg```
- Open stucture: ```,b```
- Save file when insert mode: ```Control + s```
- Save file when normal mode: ```,s```
- Split file: ```,sv``` 

