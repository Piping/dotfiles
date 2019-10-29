" ███████╗██╗  ██╗   ██╗███╗   ███╗ █████╗ ███╗   ██╗
" ██╔════╝██║  ╚██╗ ██╔╝████╗ ████║██╔══██╗████╗  ██║
" █████╗  ██║   ╚████╔╝ ██╔████╔██║███████║██╔██╗ ██║
" ██╔══╝  ██║    ╚██╔╝  ██║╚██╔╝██║██╔══██║██║╚██╗██║
" ██║By   ███████╗██║   ██║ ╚═╝ ██║██║  ██║██║ ╚████║
" ╚═╝ROBIN╚══════╝╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""   UNIVERSAL VIM OPTIONS THAT WE ARE ALL AGREED  """"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Turn on the Wild menu
set wildmenu

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Use spaces instead of tabs
set expandtab

set autoindent 
set smartindent

set showcmd      "Always print current keystroke
set ruler        "Always show current position

" Work with longline
set display+=lastline

set encoding=utf8

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

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface element
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" A buffer becomes hidden instead of dropped
set hidden
set confirm

" Don't redraw while executing macros (good performance config)
set lazyredraw

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn backup off, since most stuff is in svn, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffers, Split Windows, Tabs(Tabline)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify the behavior when switching/opening new buffers
if v:version >= 740
    set switchbuf=useopen,usetab
endif
" Always Show tabline
set showtabline=2
" Set Split Position
set splitright
set splitbelow

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Word Completion Popup Menu Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set pumheight=25
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Set Preferred Input Timeout
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set notimeout
set ttimeout
set ttimeoutlen=0  " No keycode dealy - no esc dealy
set scrolloff=0    " allow cursor to be at top and bottom

silent! packadd! matchit

nnoremap q :q<cr>
nnoremap K K<cr>
"""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<space>"

"""""""""""""""""""""""""""""""""""""""""
"" All leader key mapping
"""""""""""""""""""""""""""""""""""""""""
" Select Buffer And Go
nnoremap <leader>b :ls<cr>:buffer
" Open empty tab or with filename
nnoremap <leader>t :tabe<space>
" quickfix window  displaying
nnoremap <leader>q :botright copen<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Vim Editor Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>l :set number!<cr>

"Split the line below with space, reverse of J
nnoremap <leader>j v$hdO<Esc>pj

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Disable highlight when <space><enter> is pressed
nnoremap <silent> <expr> <cr> &buftype ==# 'quickfix' ? "\<cr>" : ":noh<cr>"

noremap <leader>r :source /etc/vimrc<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Repeate last command line execution
nnoremap <leader><space> @:

" Quickly add empty lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Quickly move current line
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" To go to the next/previous quickfix/linter entry in a different file
" nnoremap <silent> [l :cpf<cr>zz 
" nnoremap <silent> ]l :cnf<cr>zz

" Utilize jumps and jumplist easier
nnoremap <silent> <Tab> <C-o>
nnoremap <silent> <S-Tab> <C-i>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => InertMode/CMDline Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Additionaly you can use c-f to editing cmd in normal mode window
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-S> <S-Right>
cnoremap <C-D> <S-Right><C-W>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
cnoremap <C-Y> <C-R>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pattern Match, Search Highlight with * key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Normal mode pressing * or # searches for word under cursor
" enable * # for visual selected text
" whitespace match any whitespace in potential result
let s:save_cpo = &cpo | set cpo&vim
function! s:VSetSearch(cmd)
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    normal! gvy
    if @@ =~? '^[0-9a-z,_]*$' || @@ =~? '^[0-9a-z ,_]*$'
        let @/ = @@
    else
        let pat = escape(@@, a:cmd.'\')
        let pat = substitute(pat, '\n', '\\n', 'g')
        let @/ = '\V'.pat
    endif
    normal! gV
    call setreg('"', old_reg, old_regtype)
endfunction
vnoremap <silent> * :<C-U>call <SID>VSetSearch('/')<cr>/<C-R>/<cr>
vnoremap <silent> # :<C-U>call <SID>VSetSearch('?')<cr>?<C-R>/<cr>
vmap <kMultiply> *
let &cpo = s:save_cpo | unlet s:save_cpo

" Delete trailing white space on save, useful for some filetypes ;)
func! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""        Utility Functions    """"""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" returns the binary string representation of a number.
function! Nr2Bin(nr)
    let n = a:nr
    let r = ""
    while n
        let r = '01'[n % 2] . r
        let n = n / 2
    endwhile
    return r
endfunc

command! CloseHiddenBuffers call s:CloseHiddenBuffers()
function! s:CloseHiddenBuffers()
    let open_buffers = []
    for i in range(tabpagenr('$'))
        call extend(open_buffers, tabpagebuflist(i + 1))
    endfor
    for num in range(1, bufnr("$") + 1)
        if buflisted(num) && index(open_buffers, num) == -1
            exec "bdelete ".num
        endif
    endfor
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Code Navigation - Cscope/LanguageClient
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! LoadCscope()
  let pwd = getcwd()
  lcd %:p:h
  let db = findfile("cscope.out", ".;")
  if (empty(db))
    let db = findfile("cscope.out", ".;")
  endif
  set nocscopeverbose
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    exe "cs add " . db . " " . path
  " else add the database pointed to by environment variable 
  elseif $CSCOPE_DB != "" 
    cs add $CSCOPE_DB
  endif
  set cscopeverbose
  exe "lcd" . " " . pwd
endfunction
if has("cscope")
    "set cscopequickfix=g-,s-,c-,f-,i-,t-,d-,e-
    set cscopequickfix=
    " add any cscope database in current directory
    map <leader>ca :cs add cscope.out<space>
    " show msg when any other cscope db added
    set cscopeverbose
    " seach for definition
    map <leader>gd  :cs find g <c-r><c-w>
    " search for this symbol
    map <leader>gs  :cs find s <c-r><c-w>
    " find the file under the name
    map <leader>gf  :cs find f <c-r><c-p>
    " search files that include this file
    map <leader>gi  :cs find i <c-r>=expand("%:t")<cr>
    " egrep pattern matching
    map <leader>ge  :cs find e <c-r><c-w>
    " Find assignments to this symbol
    map <leader>ga  :cs find a <c-r><c-w>
    " search functions that call this function
    map <leader>gc  :cs find c <c-r><c-w>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => colors , fonts, display, highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! DisplayReloadTheme()
    silent! colorscheme default
    " Set the Syntax
    syntax on
    set cursorline
    if $TERM  =~? '256color'
        set t_Co=256
    endif
    set number
    " show hidden chars using shortcuts
    set listchars=tab:␉·,eol:␤,nbsp:▓
    set nolist
    " two highlight group nontext & specialkey for listchars
    highlight nontext ctermfg=238 guifg=#414141
    " override color scheme for the listchars "#649a9a
    highlight CursorLine guibg=#404040 gui=bold cterm=bold ctermbg=234

    highlight QuickFixLine term=reverse ctermbg=254
    highlight QuickFixLine gui=reverse guibg=#000000

    highlight Visual cterm=bold ctermbg=white ctermfg=Black
    highlight Visual gui=bold guibg=white guifg=Black

    highlight Search cterm=bold ctermbg=Yellow ctermfg=black
    highlight Search gui=bold guibg=Brown guifg=black

    set laststatus=2 "In order to show the good statusline
    set showcmd      "Always print current keystroke
    set ruler        "Always show current position
    set cmdheight=1  "Height of the command bar
    set statusline=
    set statusline+=\ %(Col:%c%) 
    set statusline+=\ %f\ %r%w         " filename and flags
    set statusline+=\ %(LoC:%L%) 
    set statusline+=%=%<      " force space and start cut if too long
    set statusline+=\ [%{getcwd()}][%{&ft}]    " flags and filetype
    set statusline+=\ [UTF-8:%B][Buf:%n]\  " unicode under cursor

    highlight Statusline cterm=bold ctermfg=black ctermbg=white
    highlight Statusline gui=bold guifg=black guibg=#b0dfe5

    highlight StatusLineNC cterm=NONE ctermfg=black ctermbg=grey
    highlight StatuslineNC gui=NONE guibg=#64645e guifg=#75715E

    highlight TabLine cterm=NONE ctermfg=252 ctermbg=239 
    highlight TabLine gui=NONE guifg=black guibg=#555555 

    highlight TabLineSel cterm=bold ctermfg=white ctermbg=black
    highlight TabLineSel gui=bold guifg=red guibg=#36454F

    highlight TabLineFill cterm=bold ctermfg=243 ctermbg=239 
    highlight TabLineFill gui=NONE guifg=#8F908A guibg=#555555

    highlight DiffAdd cterm=bold ctermfg=green ctermbg=white
    highlight DiffChange cterm=bold ctermfg=black ctermbg=white
    highlight DiffDelete cterm=bold ctermfg=red ctermbg=white
    highlight DiffText cterm=bold ctermfg=brown ctermbg=white

    highlight MatchParen cterm=bold ctermfg=white ctermbg=brown

    highlight Pmenu    cterm=bold ctermfg=white ctermbg=brown
    highlight PmenuSel cterm=reverse ctermfg=white ctermbg=brown
    highlight PmenuThumb cterm=bold ctermbg=white
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""    AUTO COMMANDS         """""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
    augroup myvimrc
        autocmd! *
        " Auto reload conffiguration file, clean whitespace for some common code files
        autocmd BufWritePost ~/.vimrc nested source ~/.vimrc | :call DisplayReloadTheme()
        autocmd BufWritePre Makefile,Makefrag,*.mk,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
        " Return to last edit position when opening files (You want this!)
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
        " Save the code folding if we had one
        " autocmd BufWinLeave * silent! mkview
        " autocmd BufWinEnter * silent! loadview
        " auto save 
        if v:version >= 740
        autocmd TextChanged * let v:errmsg = '' | silent! write | if v:errmsg == '' | write | endif
        autocmd InsertLeave * let v:errmsg = '' | silent! write | if v:errmsg == '' | write | endif
        endif
        " smart cursorline
        autocmd WinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
        " tab special for makefile 
        autocmd FileType make setlocal noexpandtab tabstop=8 shiftwidth=8
        autocmd VimEnter * :call LoadCscope()
    augroup END
endif

call DisplayReloadTheme()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""    END OF VIM OPTIONS SETTING    """"""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim: set ft=vim :
