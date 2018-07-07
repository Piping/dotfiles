# Created by newuser for 5.4.2
# exit for non-interactive shell
[[ $- != *i* ]] && return

# 常用命令
case `uname` in
    Darwin)
        # commands for OS X go here
        alias ls='ls -G'
        alias ll='ls -altrG'
        export LSCOLORS=exfxcxdxbxexexabagacad
        ;;
    Linux)
        # commands for Linux go here
        alias ls='ls --color=auto'
        alias ll='ls -altr --color=auto'
        ;;
    FreeBSD)
        # commands for FreeBSD go here
        ;;
esac

alias vi='vim'
alias vimc='vim -i NONE -u NONE -N'

alias docker_clean_images='docker rmi -f $(docker images -a --filter=dangling=true -q)'
alias docker_clean_ps='docker rmi -f $(docker ps --filter=status=exited --filter=status=created -q)'

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

# Key Binding
KEYTIMEOUT=10 # 100 = 1 second for key sequences

bindkey -e

bindkey '^Z' backward-word
bindkey '^X' forward-word
bindkey '^W' backward-kill-word
bindkey '^D' kill-word
bindkey "^[[3~" backward-delete-char  #设置 [DEL]键 为向后删除

WORDCHARS='*?_-[]~=&;!#$%^(){}<>'     #以下字符视为单词的一部分

loop() {
    while true; do
        eval "$@"
    done
}
loopn() {
    local n="$1"
    shift
    for i in {1..$n}; do
        eval "$@"
    done
}
loopf() {
    for i in *; do
        eval "$@" "$i"
    done
}

# options
unsetopt correct_all

#{{{ 关于历史纪录的配置
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTFILE=$HOME/.zhistory
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

if true; then
    # Zim initializition
    export ZIM_HOME="$HOME/.zsh"

    if [ ! -f "$ZIM_HOME/init.zsh" ]; then
        echo "Installing zim"
        git clone --recursive https://github.com/zimfw/zimfw.git $ZIM_HOME
        git clone https://github.com/Piping/fzf-zsh.git $ZIM_HOME/modules/fzf-zsh
        cat $ZIM_HOME/templates/zlogin >> $HOME/.zlogin
        source $HOME/.zlogin
    fi

    zmodules=(git git-info prompt completion syntax-highlighting autosuggestions fzf-zsh)
    zprompt_theme='steeef'
    zhighlighters=(main brackets cursor pattern)

    source $ZIM_HOME/init.zsh #make sure init after zmodules lists etcs..
fi


if false; then
    export ZPLUG_HOME="$HOME/.zplug"

    if [ ! -f "$ZPLUG_HOME/init.zsh" ]; then
        echo "Installing zplug"
        git clone https://github.com/zplug/zplug $ZPLUG_HOME
    fi

    source $ZPLUG_HOME/init.zsh

    zplug "mafredri/zsh-async", from:github
    zplug "sindresorhus/pure, use:pure.zsh", from:github, as:theme
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-completions"
    zplug "piping/fzf-zsh"
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi

    zclean_cache() {
        rm -f ${HOME}/.zshrc.zwc{,.old}
        rm -f ${HOME}/.zcompdump{,.zwc{,.old}}

        find ${ZPLUG_HOME} \( -name '*.zwc' -or -name '*.zwc.old' \) -delete
    }

    zcompare() {
        if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
            zcompile ${1}
        fi
    }

    znew_cache() {
        zclean_cache

        ( local file
        setopt LOCAL_OPTIONS EXTENDED_GLOB

        zcompare ${HOME}/.zshrc
        zcompare ${HOME}/.zcompdump

        # zcompile the completion cache; siginificant speedup
        zcompare ${ZPLUG_HOME}/zcompdump

        # zcompile enabled module scripts
        for file in ${ZPLUG_HOME}/cache/*.zsh; do
            zcompare ${file}
        done) &!
    }

    zplug load #--verbose
fi
