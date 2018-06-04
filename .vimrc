""""""""""""""""""""""""""""""
"""" vim-plug for lazy loading plugin management
"""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/temp_dirs/undodir > /dev/null 2>&1
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""
Plug 'itchyny/lightline.vim'
set laststatus=2 ""In order to show the lightline
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"Plug 'crusoexia/vim-monokai'
"colorscheme monokai
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'ErichDonGubler/vim-sublime-monokai'
"colorscheme sublimemonokai "not ready here, set it later
""""""""""""""""""""""""""""""

Plug 'jiangmiao/auto-pairs'

Plug 'majutsushi/tagbar'       , {'on': 'TagbarToggle'}

""""""""""""""""""""""""""""""
"On demand loading
Plug 'Chiel92/vim-autoformat'  , { 'on':  'Autoformat' }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'godlygeek/tabular'       , { 'on': 'Tabularize' }
""""""""""""""""""""""""""""""

Plug 'ajh17/VimCompletesMe'

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
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim' , {'on': ['Buffers','History','Ag']} ", 'do': ':Plug ''junegunn/fzf'' '}
" Plug 'lvht/fzf-mru' , {'on': 'FZFMru'}
"""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'junegunn/goyo.vim' , {'on': 'Goyo'}
noremap <leader>z :Goyo<CR>
""""""""""""""""""""""""""""""

Plug 'sheerun/vim-polyglot'

""""""""""""""""""""""""""""""
" Plug 'Houl/repmo-vim'
" " map a motion and its reverse motion:
" :noremap <expr> h repmo#SelfKey('h', 'l')|sunmap h
" :noremap <expr> l repmo#SelfKey('l', 'h')|sunmap l
" :noremap <expr> J repmo#SelfKey('J', 'K')|sunmap J
" :noremap <expr> K repmo#SelfKey('K', 'J')|sunmap K
" " if you like `:noremap j gj', you can keep that:
" :map <expr> j repmo#Key('gj', 'gk')|sunmap j
" :map <expr> k repmo#Key('gk', 'gj')|sunmap k
" " repeat the last [count]motion or the last zap-key:
" :map <expr> ; repmo#LastKey(';')|sunmap ;
" :map <expr> . repmo#LastRevKey('.')|sunmap .
" " add these mappings when repeating with `;' or `,':
" :noremap <expr> f repmo#ZapKey('f')|sunmap f
" :noremap <expr> F repmo#ZapKey('F')|sunmap F
" :noremap <expr> t repmo#ZapKey('t')|sunmap t
" :noremap <expr> T repmo#ZapKey('T')|sunmap T
""""""""""""""""""""""""""""""

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

""PLUGIN LEADER KEY MAPPING"
map    <C-f>       :FZF <Cr>
map    <leader>ff  :FZF ~
nmap   <leader>b   :Buffers<Cr>
" Alt-Enter to execute command
nmap   <leader>cf  :History:<Cr>
" nmap   <leader>a   :Ag
vmap   <leader>a   :Tabularize /
map    <leader>f   :Autoformat<Cr>



" Fast saving
nmap <leader>w :w!<cr>
" Fast Normal Mode Cmd
inoremap <leader>. <C-o>
" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
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

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

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


" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme sublimemonokai
" truecolor from iTerm2 etc
set termguicolors

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

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


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper function
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'replace'
        call feedkeys(":"."%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/untitled.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>e :e! ~/.vimrc<cr>
autocmd! bufwritepost ~/.vimrc source ~/.vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cope displaying
map <leader>cc :botright cope<cr>
" To go to the next search result do:
map <leader>n :cn<cr>
" To go to the previous search results do:
map <leader>p :cp<cr>

set showcmd
set number
set mouse=a
set ttymouse=xterm2
set nottimeout
set notimeout
set scrolloff=0 "allow cursor to be at top and bottom
" set virtualedit=all "allow cursor to be anywhere
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => InertMode/CMDline Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap VIM = to line end $
noremap = $
" InsertMode with Emacs Shortcut Mapping
inoremap <C-A> <Home>
inoremap <C-E> <End>
" My Custom Emacs-Style Move Shortcut
inoremap <C-Z> <Esc>bi
inoremap <C-X> <Esc>wwi
" Delete/Cut forward word
inoremap <C-D> <Esc>edbxxi
" Delete/Cut Word After Cursor
inoremap <C-K> <Esc>lDai
" Delete/Cut Whole Line, mimic zsh
inoremap <C-U> <Esc>ddi
" Paste/Yank
inoremap <C-Y> <Esc>Pa
" Same as above, works for cmdline
cnoremap <C-D> <S-Right><C-W>
cnoremap <C-Z> <S-Left>
cnoremap <C-X> <S-Right>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Vim Editor Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>q  :q<Cr>
map <leader>nn :Lexplore!<Cr>
" set 'p' to paste before cursor
nnoremap p P
nnoremap P p
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cursor Moving mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keep the cursor at center they are and move whole page
noremap J <C-e>j
noremap K <C-y>k

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Code Development - TagBar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>mm :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Code Development - Cscope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set cscopetag   " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
    " check cscope for definition of a symbol before checking ctags:
    " set to 1 if you want the reverse search order.
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
    " search for C Symbol
    map <leader>css :tab cs find s <C-R>=expand("<cword>")<CR><CR>
    " seach for Global Definition
    map <leader>csg :tab cs find g <C-R>=expand("<cword>")<CR><CR>
    " search functions that call this function
    map <leader>csc :tab cs find c <C-R>=expand("<cword>")<CR><CR>
    " search this string
    map <leader>cst :tab cs find t <C-R>=expand("<cword>")<CR><CR>
    " egrep pattern matching
    map <leader>cse :tab cs find e <C-R>=expand("<cword>")<CR><CR>
    " search this file
    map <leader>csf :tab cs find f <C-R>=expand("<cfile>")<CR><CR>
    " search files that include this file
    map <leader>csi :tab cs find i <C-R>=expand("<cfile>")<CR><CR>
    " search for functions are called by this function
    map <leader>csd :tab cs find d <C-R>=expand("<cword>")<CR><CR>
endif

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set cmdheight=1
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set cmdheight=2
    endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>

" Special Configuration
" augroup FastLeaderKeyInsertMode
"   autocmd!
"   au TextChangedI * if strcharpart(getline('.')[col('.') - 1:], 0, 1) == ',' | set timeoutlen=200 | end
"   au TextChangedI * set timeoutlen=0
" augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""
" Add my script to toggle <C-f> fzf search type
""""""""""""""""""""""""""""""""""""""""""""""""""




