# dotfiles
我的 zsh + tmux + vim 配置, 该配置使用了以下库

* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* [autojump](https://github.com/wting/autojump)
* 我的vim配置 [vimfiles](https://github.com/riag/vimfiles) 
* [powerline 字体](https://github.com/powerline/fonts)

## 安装
直接使用 `./install.sh` 来安装

## 安装 powerline 字体
使用了 `UbuntuMono` 字体，cygwin下的mintty使用了 `consolas-font-for-powerline`字体

### windows
* 如果你是在cygwin环境下，不需要执行 `./install_font.sh` 安装字体
只需从 https://github.com/runsisi/consolas-font-for-powerline 安装 `consolas-font-for-powerline` 字体

* 如果你远程连接linux来工作的，远程的linux系统也不需要安装字体，只需在windows下安装字体, 并把ssh client的字体改为该字体就可以了
从 https://github.com/powerline/fonts 下载字体，安装`UbuntuMono`字体

windows 下安装字体很容易，只需双击ttf字体文件就可以了

### linux
如果你是工作在linux的本地环境，就需要安装字体，直接执行 `./install_font.sh` 安装字体

## 定制
你可以在以下这些文件里定制你的配置
```
~/.zshrc.local
~/.vimfiles/vimrc.vim.local
~/.tmux.conf.local
```
