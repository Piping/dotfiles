"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" vim-plug for lazy loading plugin management
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/temp_dirs/undodir > /dev/null 2>&1
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set viminfo+=n~/.vim/.viminfo
" set this time here to quickly load the ymc afterward
set updatetime=100

call plug#begin('~/.vim/plugged')
""""""""""""""""""""""""""""""
"" LIGHTLINE PLUGIN
""""""""""""""""""""""""""""""
Plug 'itchyny/lightline.vim'
set laststatus=2 "In order to show the lightline
set showcmd      "Always print current keystroke
set ruler        "Always show current position
set cmdheight=1  "Height of the command bar
let g:lightline = {'active':{
            \ 'left' : [[ 'mode', 'paste' ],['filename','readonly','modified' ]],
            \ 'right': [['lineinfo'],['percent']]}, }
let g:lightline.tabline = {
            \ 'left': [ [ 'my_text','tabs' ] ],
            \ 'right': [ [ 'close' ] ] }
let g:lightline.tab =
            \{'active': [ 'tabnum', 'modified' ],
            \ 'inactive': [ 'tabnum','modified'],}
let g:lightline.tabline_separator = {'left':'','right':''}
let g:lightline.tabline_subseparator = {'left':'','right':''}
let g:lightline.component = { 'my_text': 'Tab:', }
" let g:lightline.component_visible_condition = { 'truncate_here': 0, }
" let g:lightline.component_type = { 'truncate_here': 'raw', }
function! LightlineReload()
    if exists('*lightline#init')
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    endif
endfunction
command! LightlineReload call LightlineReload()
"the color scheme variable only available before VimEnter
"Tab_FG_Color,Tab_BG_Color
autocmd VimEnter *
            \ let g:lightline#colorscheme#default#palette.tabline.tabsel = [[ '#f62d6c', '#2d2e27', 252, 66, 'bold' ]] |
            \ let g:lightline#colorscheme#default#palette.tabline.middle = [[ '#d0d0d0', '#2d2e27', 252, 66, 'bold' ]] |
            \ let g:lightline#colorscheme#default#palette.tabline.right  = [[ '#606060', '#2d2e27', 252, 66, 'bold' ]] |
            \ let g:lightline#colorscheme#default#palette.tabline.left   = [[ '#606060', '#2d2e27', 252, 66, 'bold' ]]
" let g:lightline#colorscheme#default#palette.tabline.left   = [[ '#606060', '#303030', 252, 66, 'bold' ]]
""""""""""""""""""""""""""""""
Plug 'mhinz/vim-startify'
""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""
Plug 'ErichDonGubler/vim-sublime-monokai'
"colorscheme sublimemonokai "cannot be set here, set it later
""""""""""""""""""""""""""""""
Plug 'joeytwiddle/repmo.vim'
let g:repmo_mapmotions = "j|k h|l zh|zl g;|g,"
let g:repmo_key = ";"
let g:repmo_revkey = ","
""""""""""""""""""""""""""""""
" Plug 'Houl/repmo-vim'
" Plug 'Houl/repmohelper-vim'
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'jiangmiao/auto-pairs'
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'majutsushi/tagbar',       {'on': 'TagbarToggle'}
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"On demand loading
Plug 'Chiel92/vim-autoformat',  { 'on':  'Autoformat' }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)','EasyAlign']}
""""""""""""""""""""""""""""""

Plug 'ajh17/VimCompletesMe'
Plug 'Valloric/YouCompleteMe',  { 'on': [],'do': './install.py --clang-completer --clang-tidy --quiet'}

""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'terryma/vim-multiple-cursors', "{'on': ???? }
let g:multi_cursor_start_word_key = '<C-d>'
let g:multi_cursor_next_key       = '<C-d>'
let g:multi_cursor_start_key      = 'g<C-d>'
let g:multi_cursor_select_all_key = 'g<A-d>'
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'w0rp/ale'
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim' , {'on': ['Ag','Commands','Buffers','History','Files']}
" CTRL-A CTRL-Q to select all and build quickfix list
" location list is similar to quickfix, specific to each window
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction
let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }
let $FZF_DEFAULT_OPTS  = "--bind ctrl-f:select-all,ctrl-g:deselect-all ".
            \ "--header ' :: Tip <C-t>TabSplit <C-x>split <C-v>vsplit \n".
            \ " :: Tip <C-f>select_all <C-g>deselect_all <C-q>send_to_quickfix'"
"""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
""""""""""""""""""""""""""""""
Plug 'sheerun/vim-polyglot'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe Lazy Loading Support
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
function! LazyLoadingVariousPlugin()
    call plug#load('YouCompleteMe') | call youcompleteme#Enable()
    echo 'YouCompleteMe Lazy Loaded'
    set updatetime=1000
    augroup LazyLoading
        autocmd!
    augroup END
endfunction

augroup LazyLoading
    autocmd CursorHold * call LazyLoadingVariousPlugin()
augroup END

" let mapleader = "\<tab>"
" nmap ,  <leader>
let mapleader = ","
"""""""""""""""""""""""""""""""""""""""""
""PLUGIN LEADER KEY MAPPING"
"""""""""""""""""""""""""""""""""""""""""
" Recently Used Files
nmap <leader>f   :History<Cr>
map  <leader>ff  :FZF<Cr>,
map  <leader>fff :FZF ~
map  <leader>fg  :Ag<Cr>
map  <leader>fgg :Ag
map  <leader>fm  :Marks<Cr>
nmap <leader>b   :Buffers<Cr>
" Recently Used Cmd, Alt-Enter to execute command
nmap <leader>c   :History:<Cr>
" Fuzzy Search ALL Vim Commands
nmap <leader>cc  :Commands<Cr>
" easy-alignment no argument go to interactive mode
vmap <leader>a   :EasyAlign
vmap <leader>aa  :EasyAlign<Cr>
nmap <leader>a   :Autoformat<Cr>
"""""""""""""""""""""""""""""""""""""""""
"" All leader key mapping
"""""""""""""""""""""""""""""""""""""""""
" Fast Normal Mode Cmd
inoremap <leader>. <C-o>
" Repeat Last Macro
nnoremap <leader>. @@
"repeat last typed command
nnoremap <leader>; @:
nnoremap <leader>' ciw"<C-r>""<Esc>
" Visual mode pressing * or # searches for the current selection
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy/<C-R><C-R>=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy?<C-R><C-R>=substitute(
            \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Vim Editor Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast saving
nmap <leader>w   :w!<Cr>
nmap <leader>q   :q<Cr>
nmap <leader>qq  :q!<Cr>
nmap <leader>qa  :qa!<Cr>
nmap <leader>nn  :Lexplore!<Cr>
" set 'p' to paste before cursor
nnoremap p P
nnoremap P p
"Join the line below with space
nnoremap <leader>j  J
"Reverse the join
nnoremap <leader>jj v$hdO<Esc>pj
nnoremap <leader>k  K
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cursor Moving mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keep the cursor at center they are and move whole page
noremap J <C-e>j
noremap K <C-y>k
" some terminal send backsapce when C-h pressed before vim
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""Join the line below with space => Code Development - TagBar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>mm :TagbarToggle<CR>
" Opens a new tab with the current buffer's path
map <leader>t  :tabnew <cr>
" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Esc, Ctrl, :, ^W, ^s, Tab, Alt
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
" nmap z= provide a list of replacement
" nmap zg add word to definition
map <leader>sa ]s
map <leader>sd [s

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>e  :e! ~/.vimrc<cr>
map <leader>et :e! ~/.tmux.conf<cr>
map <leader>ez :e! ~/.zshrc<cr>
autocmd! bufwritepost ~/.vimrc source ~/.vimrc | LightlineReload
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quickfix window  displaying
map <leader>co  :botright copen<cr>
map <leader>coo :cclose<cr>
" To go to the next quickfix result:
map <leader>n :cn<cr>
" To go to the previous quickfix result:
map <leader>p :cp<cr>

map <leader>h :helpclose<cr>
let s:statusline_mode = 0
function! ToggleHiddenAll()
    if s:statusline_mode  == 0
        let s:statusline_mode = 1
        set showmode
        set noruler
        set laststatus=0
        set showcmd
        set cmdheight=1
        if mode() == 'n'
            echohl ModeMsg
            echomsg '-- NORMAL --'
            echohl None
        endif
    elseif s:statusline_mode == 1
        " nothing is show
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set cmdheight=1
        let s:statusline_mode = 2
        " call feedkeys("1\<C-g>")
        echo ''
    elseif s:statusline_mode == 2
        " default status line
        let s:statusline_mode = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set cmdheight=1
        echo ''
    endif
endfunction
nnoremap <leader>hh :call ToggleHiddenAll()<cr>

let s:auto_normal_mode = 0
function! ToggleAutoNormalMode()
    if s:auto_normal_mode == 1
        let s:auto_normal_mode = 0
        augroup AutoNormalMode
            autocmd! *
        augroup END
        echohl ModeMsg | echo '-- NORMAL(PERSIST) --' | echohl None
    else
        let s:auto_normal_mode = 1
        " Automitically enter the normal mode after sometime
        augroup AutoNormalMode
            au CursorHoldI  * stopinsert
            au CursorMovedI * let updaterestore=&updatetime | set updatetime=1000
            au InsertEnter  * let updaterestore=&updatetime | set updatetime=1000
            au InsertLeave  * let &updatetime=updaterestore
        augroup END
        echohl ModeMsg | echo '-- NORMAL(AUTO) --' | echohl None
    endif
endfunction
" I Use Auto-Normal Mode by Default
silent call ToggleAutoNormalMode()
nnoremap <leader>hn :call ToggleAutoNormalMode()<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Zoomed Window
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap  <leader>zz  :Goyo<cr>
nmap  <leader>z   :call ToggleOnlyWindow()<cr>
let s:zoomed_windows_b = 0
function! ToggleOnlyWindow()
    if s:zoomed_windows_b == 0
        let s:zoomed_windows_b = 1
        wincmd _ " slient call feedkeys('\<C-w>_')
        wincmd |
    else
        let s:zoomed_windows_b = 0
        wincmd =
    endif
endfunction
"Not Used Anymore
function! ToggleOnlyWindowUsingSession()
    if s:zoomed_windows_b == 0
        let s:zoomed_windows_b = 1
        mksession! ~/.vim/zoom_windows_layout_session_tmp.vim
        wincmd o " slient call feedkeys('\<C-w>o')
    else
        let s:zoomed_windows_b = 0
        source ~/.vim/zoom_windows_layout_session_tmp.vim
    endif
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Avoid garbled characters in Chinese language windows OS
let $LANG='cn'
set langmenu=cn
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
	
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
silent! colorscheme sublimemonokai
" truecolor from supported terminal etc
set termguicolors

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
" Show Hidden Chars 
" http://www.theasciicode.com.ar/extended-ascii-code/acute-accent-ascii-code-239.html
set list
set listchars=tab:>·,eol:■,nbsp:▓
" Overrite Color Scheme for the listchars "#649A9A
" Two highlight group NonText & SpecialKey
" EOL
" TAB
	
highlight NonText ctermfg=238 guifg=#414141
" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry

set number
set autowrite
set mouse=a
set ttymouse=xterm2 | if $TMUX=="" | set ttymouse=xterm | endif
set timeout
set ttimeout
set timeoutlen=300 " for <leader> mapping
set ttimeoutlen=0
set scrolloff=0 "allow cursor to be at top and bottom
" set virtualedit=all "allow cursor to be anywhere
" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pattern Match, Search Highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search)
map <space> /
" Disable highlight when <leader><cr> is pressed
nmap <silent> <leader><cr> :noh<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Delete trailing white space on save, useful for some filetypes ;)
func! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
" userful to redirect internal command output to paste buffer
func! Exec(command)
    redir =>output
    silent exec a:command
    redir END
    return output
endfunct!

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => InertMode/CMDline Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap = to line end $, like it, easier to press and remember
noremap = $
" Remap  = filter to |
noremap \| =
" Map _ to be reverse of -, move cursor one line upward and beginning of the word
" noremap _ ddkp
" InsertMode with Emacs Shortcut Mapping
inoremap <C-A> <Home>
inoremap <C-E> <End>
" My Custom Emacs-Style Move Shortcut
inoremap <C-Z> <S-Left>
inoremap <C-X> <S-Right>
inoremap <C-W> <Esc>ldbi
" Delete/Cut forward word
inoremap <C-D> <Esc>dwi
" Delete/Cut Word After Cursor
inoremap <C-K> <Esc>lDa
" Delete/Cut Whole Line, mimic zsh
inoremap <C-U> <Esc>ddi
" Paste/Yank -- does not work with YMC??
inoremap <C-Y> <C-r>"
" Same as above, works for cmdline
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-Z> <S-Left>
cnoremap <C-X> <S-Right>
cnoremap <C-D> <S-Right><C-W>
cnoremap <C-K> <C-u>
" paste is not working properly
cnoremap <C-Y> <C-r>"
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Code Development - Cscope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set cscopequickfix=g-,s-,c-,f-,i-,t-,d-,e-
    set csto=1

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add the database pointed to by environment variable
    elseif $CSCOPE_DB !=""
        cs add $CSCOPE_DB/cscope.out $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose
    " search for c symbol
    map <leader>gs :tab cs find s <c-r>=expand("<cword>")<cr><cr>
    " seach for global definition
    map <leader>gg :tab cs find g <c-r>=expand("<cword>")<cr><cr>
    " search functions that call this function
    map <leader>gc :tab cs find c <c-r>=expand("<cword>")<cr><cr>
    " search this string
    map <leader>gt :tab cs find t <c-r>=expand("<cword>")<cr><cr>
    " egrep pattern matching
    map <leader>ge :tab cs find e <c-r>=expand("<cword>")<cr><cr>
    " search this file
    map <leader>gf :tab cs find f <c-r>=expand("<cfile>")<cr><cr>
    " search files that include this file
    map <leader>gi :tab cs find i <c-r>=expand("<cfile>")<cr><cr>
    " search for functions are called by this function
    map <leader>gd :tab cs find d <c-r>=expand("<cword>")<cr><cr>
endif


" Special Configuration
" augroup FastLeaderKeyInsertMode
"   autocmd!
"   au TextChangedI * if strcharpart(getline('.')[col('.') - 1:], 0, 1) == ',' | set timeoutlen=200 | end
"   au TextChangedI * set timeoutlen=0
" augroup END
" let query = input('Functions calling: ')
