![show](screencast.png)
# dotfiles
A set of terminal configuration files for zsh, tmux, vim (fast, simple, minimal, off the shelf).  
All options and UI are carefully crafted, no boilerplate, no gaint dependency!.
All files work flawlessly on development and production server.

## How to use these files
- put them under your home folder. E.g. `~/.vimrc`

## Principle
- never remove or replace the deault keybinding, applies your knowledge, only enhancements.
- compatible across different terminals, linux distrubutions, and OS
- productive and professional 
- minimal redundant information on USER Interface! It is clean while infomative!

## VIM
- Features List
  - single-hand browsing is never been easier
  - auto-save file, no need to press :w to save file anymore
  - unlimited undo history, fearless edititng
  - **50ms** startup time, every ms counts! always fast!
  - configuration file auto-reload on modified inside vim
  - carefully selected high quality plugins that is absolutely improve productivity
  - crafted UX that is modern and prove its quality in details
  - search visual selection with */# key
  - straightforward buffer list management
  - quick and accurate file search using fzf, also (commits,grep,commands, history ...)
  - user-firendly and efficient undotree panel
  - works without any plugins if thats your style

## TMUX
- Best TMUX Configuration as far as I know 
  - User Experience Oriented, especially for users that are new to CLI
  - Native COPY/PASTE experience across terminal/OS. Never been easier than this!
  - crafted UX that is modern and prove its quality in details

## Dependency && Install
Most up to date desktop linux does not need install anything and it will work.  
For server users, here is a list of troubleshoots and environement configurations.
- Plugin-version of `vimrc` requires the python support if you want the autocompelte features, make sure in vim `has('python')` return 1;
- vim8.0+ required
- vim should be compiled with python, and huge-feature-set
- tmux need version 2.6+
- if the color does not looks right, do the following 
    - `yum install xterm`
    - `export TERM=xterm-256color`
    - `export TERMINFO=/usr/share/terminfo`
    - put above exports into your bashrc or zshrc
    - `source ~/.bashrc`
    - if above tips do not help, change your terminal emulator to iTerm2/Chrome Secure Shell Extension

## Sreencast, configurations, key-mapping explained
- TMUX
  - prefix is `` ` `` (backtick under ~) or `Ctrl-b`
  - press prefix twice to send `` ` `` (backtick under ~) or `Ctrl-b`
  - Dettach && Attach to Mantain the Session
    - `<prefix> d`   ; dettach
    - `<prefix> D`   ; dettach other users 
    - `tmux attach` ; attach to last access Session
    - `tmux attach -t <session id>` ;attach to <session>
    - `tmux list-sessions` ; list sessions
  - COPY/PASTE
    - mouse
      - left click and drag to select, copy on stop
      - middle/right click to paste
    - keyboard
      - `<prefix> Enter` ; enter copy mode
      - `Enter` ; exit copy mode
      - vi-key binding to move cursor 
      - `v` ; start selection
      - `y` ; copy/yank the text
      - `<prefix> p` ; paste the text from buffer
    - Search Display Buffer
      - `<prefix> /` ; search upward
      - Under COPY MODE
        - `/` search forward
        - `?` search backward
  - Create Windows/Navigate
    - `<prefix> c   `; create new windows
    - `<prefix> 1-9 `; go to windows 1-9
    - `<prefix> n   `; go to next windows
    - `<prefix> -   `; create horizontal split
    - `<prefix> \   `; create vertical split
  - TMUX pane features
    - `<prefix> a`   ; go to last acessed window
    - `<prefix> l`   ; create a split layout like H
    - `<prefix> z`   ; ZOOM the current pane to use all display space
    - `<prefix> s`   ; synchornize the input in all panels under the same window
    - `<prefix> x`   ; kill the current panel
    - `<prefix> ,`   ; rename the windows
    - `<prefix> T`   ; rename the pane
    - `<prefix> t`   ; show clock
  - TMUX command line
    - `<prefix> :`   ; enter command line
    - `<esc>`        ; editing cmdline with vi-key binding

