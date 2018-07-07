# Created by newuser for 5.4.2
# exit for non-interactive shell
[[ $- != *i* ]] && return

# 常用命令
alias ls='ls --color=auto'
alias ll='ls -altr --color=auto'
alias vi='vim'
alias vimnn='vim -i NONE -u NONE -N'

# 文件别名
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
alias -s xz='tar -xf'
alias -s sh='bash'
alias -s py='python'

export EDITOR=vim
export PAGER='less -irf'
export GREP_COLOR='40;33;01'
export TERM="xterm-256color"
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export ZPLUG_HOME="$HOME/.zsh"

# options
unsetopt correct_all

#{{{ 关于历史纪录的配置
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTFILE=$ZPLUG_HOME/.zsh_history
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
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt EXTENDED_HISTORY          #为历史纪录中的命令添加时间戳
setopt AUTO_PUSHD                #启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt PUSHD_IGNORE_DUPS         #相同的历史路径只保留一个
setopt HIST_IGNORE_SPACE         #在命令前添加空格，不将此命令添加到纪录文件中
unsetopt beep
#}}}

# Key Binding
bindkey -e
KEYTIMEOUT=10 # 100 = 1 second for key sequences
bindkey '^Z' backward-word
bindkey '^X' forward-word
bindkey '^W' backward-kill-word
bindkey '^D' kill-word
bindkey "^[[3~" backward-delete-char  #设置 [DEL]键 为向后删除
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'     #以下字符视为单词的一部分

# Tab Menu Selection
setopt AUTO_LIST
setopt AUTO_MENU

# completion rules
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
# 只修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# zstyle ':completion:*' matcher-list 'r:|?=** m:{a-z\-}={A-Z\_}' #fuzzy complete
# 错误校正
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 2 numeric
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

# Disable Ctrl-S freeze
stty -ixon

if [ ! -f "$ZPLUG_HOME/init.zsh" ]; then
    echo "Installing zplug"
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source $ZPLUG_HOME/init.zsh

zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

# zplug "rupa/z.sh"

zplug "zsh-users/zsh-autosuggestions"

zplug "zsh-users/zsh-completions"

zplug "piping/fzf-zsh"

# about 20ms
zplug "zsh-users/zsh-syntax-highlighting", defer:2
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

# Install plugins if there are plugins that have not been installed
# about 10ms
# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     fi
# fi

# Then, source plugins and add commands to $PATH
zplug load #--verbose
