# exit for non-interactive shell
[[ $- != *i* ]] && return

# Antigen: https://github.com/zsh-users/antigen
ANTIGEN="$HOME/.local/bin/antigen.zsh"

# Install antigen.zsh if not exist
if [ ! -f "$ANTIGEN" ]; then
    echo "Installing antigen ..."
    [ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local" 2> /dev/null
    [ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null
    URL="http://git.io/antigen"
    TMPFILE="/tmp/antigen.zsh"
    if [ -x "$(which curl)" ]; then
        curl -L "$URL" -o "$TMPFILE"
    elif [ -x "$(which wget)" ]; then
        wget "$URL" -O "$TMPFILE"
    else
        echo "ERROR: please install curl or wget before installation !!"
        exit
    fi
    if [ ! $? -eq 0 ]; then
        echo ""
        echo "ERROR: downloading antigen.zsh ($URL) failed !!"
        exit
    fi;
    echo "move $TMPFILE to $ANTIGEN"
    mv "$TMPFILE" "$ANTIGEN"
fi

export PATH="$PATH:$HOME/.bin"
export EDITOR=vim
export PAGER='less -irf'
export GREP_COLOR='40;33;01'

# Enable 256 color to make auto-suggestions look nice
export TERM="xterm-256color"

# WSL (aka Bash for Windows) doesn't work well with BG_NICE
[ -d "/mnt/c" ] && [[ "$(uname -a)" == *Microsoft* ]] && unsetopt BG_NICE

# Initialize antigen
source "$ANTIGEN"

# visit https://github.com/unixorn/awesome-zsh-plugins
antigen bundle nojhan/liquidprompt

# antigen bundle git
# antigen bundle heroku
antigen bundle pip
antigen bundle svn-fast-info
# antigen bundle command-not-find
antigen bundle colorize
antigen bundle github
antigen bundle python
antigen bundle rupa/z z.sh
# antigen bundle z
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
# antigen bundle supercrabtree/k
# antigen bundle Vifon/deer
antigen bundle willghatch/zsh-cdr
# antigen bundle zsh-users/zaw
antigen bundle piping/fzf-zsh

# syntax color definition
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]=none

# enable syntax highlighting, use above customization
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

# options
unsetopt correct_all

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY # Don't execute immediately upon history expansion.

#{{{ 关于历史纪录的配置
#历史纪录条目数量
export HISTSIZE=100000000
#注销后保存的历史纪录条目数量
export SAVEHIST=100000000
#历史纪录文件
export HISTFILE=~/.zhistory
#分享历史纪录
setopt SHARE_HISTORY
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS
#为历史纪录中的命令添加时间戳
setopt EXTENDED_HISTORY
#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS
#在命令前添加空格，不将此命令添加到纪录文件中
setopt HIST_IGNORE_SPACE
unsetopt beep
#}}}

#{{{ 杂项

# 扩展路径
# /v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word

# 禁用 core dumps
#limit coredumpsize 0

# in macos terminal: Alt/Esc: ^[  Ctrl:^  arrow:^[[
# -e emacs mode, -v vi mode
bindkey -e
# 100 = 1 second for key sequences
KEYTIMEOUT=10
bindkey '^Z' backward-word
bindkey '^X' forward-word
bindkey '^|' quote-line
bindkey '^]' quote-region
bindkey '^W' backward-kill-word
bindkey '^D' kill-word
#设置 [DEL]键 为向后删除
bindkey "^[[3~" backward-delete-char
#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'
#}}}

#{{{ 自动补全功能,使用Ctrl-c取消补全,添加'$fpath'处理额外补全文件

setopt AUTO_LIST
setopt AUTO_MENU
# 开启此选项，补全时会直接选中菜单项,否则按两下tab
# setopt MENU_COMPLETE

_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1    # Because we didn't really complete anything
}

#TEMPLATE: zstyle :completion:function:completer:command:argument:tag

zstyle ':completion:::::' completer _force_rehash _complete _approximate


# 自动补全选项
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

# 路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion::complete:*' '\\'

# 彩色补全菜单
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 模糊补全:太过强大
# zstyle ':completion:*' matcher-list 'r:|?=** m:{a-z\-}={A-Z\_}'
# 只修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# 错误校正
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# 补全类型提示分组
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages'     format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings'     format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections'  format $'\e[01;32m -- %d (errors: %e) --\e[0m'

# kill 补全
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

# cd ~ 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'

autoload -Uz compinit && compinit -u

# 空行(光标在行首)补全 "cd "
user-complete() {
case $BUFFER in
    "" )
        # 空行填入 "cd "
        BUFFER="cd "
        zle end-of-line
        zle expand-or-complete
        ;;

    " " )
        BUFFER="!?"
        zle end-of-line
        zle expand-or-complete
        ;;

    * )
        zle expand-or-complete
        ;;
esac
}

zle -N user-complete
bindkey "\t" user-complete

#}}}

# 常用命令

alias ls='ls --color=auto'
alias ll='ls -altr --color=auto'
alias vi='vim'

# 文件别名
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
alias -s xz='tar -xf'
alias -s sh='bash'
alias -s py='python'

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
# LuqidPrompt
# set | grep ^LP_ENABLE_
LP_ENABLE_SVN=0
LP_ENABLE_TEMP=0
LP_ENABLE_GIT=0
# disable Ctrl-S freeze
stty -ixon
# setup FZF path for zsh
if [ ! -f ~/.local/bin/fzf ] && [ -f ~/.vim/plugged/fzf/bin/fzf ]; then
    ln -s ~/.vim/plugged/fzf/bin/fzf ~/.local/bin/fzf
fi
if [ -x "$(command -v fzf)" ]; then
    source ~/.antigen/bundles/piping/fzf-zsh/fzf-zsh.plugin.zsh
    if [ -x "$(command -v ag)" ]; then
        export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_DEFAULT_OPTS='
        --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
        --color info:108,prompt:109,spinner:108,pointer:168,marker:168
        '
    fi
fi
