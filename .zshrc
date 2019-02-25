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
        export LS_COLORS='rs=0:di=1;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
        alias ls='ls --color=auto'
        alias ll='ls -altr --color=auto'
        ;;
    FreeBSD)
        # commands for FreeBSD go here
        ;;
esac

alias vi='vim'
alias vimc='vim -i NONE -u NONE -N'

alias g='git'

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

#color for less and manpage that uses less command
export LESS_TERMCAP_mb=$'\e[0;32m'     #mb: start blink
export LESS_TERMCAP_md=$'\e[0;32m'     #md: start bold
export LESS_TERMCAP_so=$'\e[1;7;33m'   #so: start standout
export LESS_TERMCAP_us=$'\e[1;4m'      #us: start underline
export LESS_TERMCAP_me=$'\e[0m'        #me: stop bold
export LESS_TERMCAP_se=$'\e[0m'        #se: stop standout
export LESS_TERMCAP_ue=$'\e[0m'        #ue: stop underline

# Disable Ctrl-S freeze and free up C-s binding
stty -ixon

# Key Binding
KEYTIMEOUT=100 # 100 = 1 second for escape 

bindkey -e
# bindkey to `main` keymap
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^W' backward-kill-word
bindkey '^D' kill-word
bindkey '^Z' backward-word
bindkey '^S' forward-word
bindkey '^R' history-incremental-search-backward
bindkey "^[[3~" backward-delete-char  #设置 [DEL]键 为向后删除
# enable unicode-char insert
autoload insert-unicode-char
zle -N insert-unicode-char
bindkey '^Xv' insert-unicode-char

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


# Zim initializition
export ZIM_HOME="$HOME/.zsh"

if [ ! -f "$ZIM_HOME/init.zsh" ]; then
    echo "Installing zim"
    git clone --recursive https://github.com/Piping/zimfw.git $ZIM_HOME
    source $ZIM_HOME/login_init.zsh
fi

zmodules=(git git-info prompt completion syntax-highlighting autosuggestions fzf-zsh)
zhighlighters=(main brackets cursor pattern)
zprompt_theme='adam2'
PROMPT_LEAN_TMUX=""

source $ZIM_HOME/init.zsh #make sure init after zmodules lists etcs..

