" ███████╗██╗  ██╗   ██╗███╗   ███╗ █████╗ ███╗   ██╗
" ██╔════╝██║  ╚██╗ ██╔╝████╗ ████║██╔══██╗████╗  ██║
" █████╗  ██║   ╚████╔╝ ██╔████╔██║███████║██╔██╗ ██║
" ██╔══╝  ██║    ╚██╔╝  ██║╚██╔╝██║██╔══██║██║╚██╗██║
" ██║By   ███████╗██║   ██║ ╚═╝ ██║██║  ██║██║ ╚████║
" ╚═╝ROBIN╚══════╝╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝

if empty(glob('~/.vim/autoload/plug.vim')) && !has('win32')
    silent! !mkdir -p ~/.vim/temp_dirs/undodir > /dev/null 2>&1
    silent! !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null 2>&1
    if v:shell_error == 0
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

" for windows oni or neovim, manually install using powershell 
" and install git for windows as well, run ` PlugInstall --sync | source $MYVIMRC ` Afterward
if 0
    md ~\AppData\Local\nvim\autoload
    $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    (New-Object Net.WebClient).DownloadFile( $uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath( "~\AppData\Local\nvim\autoload\plug.vim"))
endif

if executable('nvim') && empty(glob('~/.config/nvim/init.vim')) && !has('win32')
    silent! !mkdir -p ~/.config
    silent! !ln -sf ~/.vim ~/.config/nvim
    silent! !ln -sf ~/.vimrc ~/.config/nvim/init.vim
endif

if has('nvim')
    set viminfo+=n~/.vim/.nviminfo
else
    set viminfo+=n~/.vim/.viminfo
    set ttymouse=xterm2 "| if $TMUX=="" | set ttymouse=xterm | endif
endif

" PLUGIN MANAGER START {{
if !empty(glob('~/.vim/autoload/plug.vim'))

    call plug#begin('~/.vim/plugged')

    """"""""""""""""""""""""""""""
    Plug 'mhinz/vim-startify'
    """"""""""""""""""""""""""""""

    """"""""""syntax and colorscheme"""""""""""""""""""
    Plug 'ErichDonGubler/vim-sublime-monokai'
    Plug 'sheerun/vim-polyglot'
    Plug 'justinmk/vim-syntax-extra'
    """"""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    " VIM's OPERATOR/TEXT OBJECT "
    """"""""""""""""""""""""""""""
    Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
    """"""""""""""""""""""""""""""
    Plug 'wellle/targets.vim'
    """"""""""""""""""""""""""""""

    """""""""""""""""""""""""""""""
    "Plug 'natebosch/vim-lsc'
    "let g:lsc_server_commands = {
    "            \ 'python' : 'pyls',
    "            \ }
    "let g:lsc_enable_diagnostics = 0

    """ Language Server Installation hint:
    """ Python: pip install 'python-language-server[all]'
    set pumheight=25
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <C-Y>   pumvisible() ? "\<C-y>" : '\<C-R>"'

    if has( 'python3' ) || has('python')
        Plug 'maralla/completor.vim'
        " let g:completor_refresh_always = 0 "avoid flickering
        let g:completor_complete_options = 'menuone,noselect'
        let g:completor_javascript_omni_trigger = "\\w+$|[\\w\\)\\]\\}\'\"]+\\.\\w*$"
        " builtin support
        let g:completor_python_binary = "/usr/local/bin/python3" 
        let g:completor_clang_binary = '/usr/local/bin/cquery-clang'
        nmap <tab> <Plug>CompletorCppJumpToPlaceholder
    else
        echohl WarningMsg
        echomsg "maralla/completor is not enabled due to lack of python support"
        echohl NONE
    endif
    """""""""""""""""""""""""""""

    """""""""""""""""""""""""""""" "On demand loading
    Plug 'chrisbra/Colorizer', { 'on': [ 'ColorHighlight', 'ColorToggle' ] }
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    ":h easyalign "check the helpdoc line 468 after load the plugin
    Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)','EasyAlign']}
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
    let g:goyo_width=130
    """"""""""""""""""""""""""""""

    call plug#end()
    "}} PLUGIN MANAGER END 
endif

silent! packadd! matchit

"""""""""""""""""""""""""""""""""""""""""
""PLUGIN LEADER KEY MAPPING"
"""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<space>"

"""""""""""""""""""""""""""""""""""""""""
""PLUGIN LEADER KEY MAPPING"
"""""""""""""""""""""""""""""""""""""""""
" easy-alignment no argument go to interactive mode
vmap <leader>a    :EasyAlign
nmap <leader>u    :UndotreeToggle<Cr>:normal! zz<cr>
map  <leader>m    :TagbarToggle<cr>:wincmd = <cr>:normal! zz<cr>
nmap <silent>     <leader>z  :Goyo<cr>:normal! zz<cr>
map  gc           <Plug>Commentary
nmap gcc          <Plug>CommentaryLine

"""""""""""""""""""""""""""""""""""""""""
"" All leader key mapping
"""""""""""""""""""""""""""""""""""""""""
" Go to Buffer
nmap <leader>b :ls<cr>:buffer

" quickfix window  displaying
map <leader>cc  :botright copen<cr>
map <leader>cq  :cclose<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Vim Editor Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>l :silent! set list! <bar> silent! set number!<cr>

"Join the line below with space
" nnoremap <leader>j  J
" Reverse of J
nnoremap <leader>j v$hdO<Esc>pj
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cursor Moving mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keep the cursor at center while scrolling
noremap <C-e> <C-e>j
noremap <C-y> <C-y>k
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""Join the line below with space => Code Development - TagBar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Disable highlight when <space><enter> is pressed
nnoremap <silent> <cr> :noh<cr>

" Esc, Ctrl, :, ^W, ^s, Tab, Alt
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sp :setlocal spell!<cr>
"  z= provide a list of replacement
"  zg add word to definition
"  ]s next spell error
"  [s previous spell error

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
" noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Repeat last typed command
nnoremap <leader>; @:

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>ee :e! ~/.vimrc<cr>
map <leader>et :e! ~/.tmux.conf<cr>
map <leader>ez :e! ~/.zshrc<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""      Buffer, Tab, Window Key Maps     """"""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>t  :tabnew<cr>

noremap <leader>r  :source $MYVIMRC<cr>

" Help Windows
if v:version >= 800
    map <leader>h :helpclose<cr>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" END of Leader Key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Extra Normal Mode Mapping 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap = to line end $, like it, easier to press and remember
noremap \ gg=G''
noremap = $
noremap <nowait> q :q<cr>
noremap <nowait> Q q

" for practicing vim way
" nnoremap <silent> <up>    <NOP>
" nnoremap <silent> <down>  <NOP>
" nnoremap <silent> <left>  <NOP>
" nnoremap <silent> <right> <NOP>

" Quickly add empty lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Quickly move current line
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" To go to the next/previous quickfix/linter entry
nnoremap <silent> [p :cprevious<cr>zz 
nnoremap <silent> ]p :cnext<cr>zz

" To go to the next/previous quickfix/linter entry in a different file
nnoremap <silent> [l :cpf<cr>zz 
nnoremap <silent> ]l :cnf<cr>zz

nnoremap <silent> '' <C-O>
nnoremap <silent> ;; <C-i>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => InertMode/CMDline Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map _ to be reverse of -, move cursor one line upward and beginning of the word
" noremap _ ddkp
" InsertMode with Extra Emacs Shortcut Mapping
inoremap <C-A> <Home>
inoremap <C-E> <End>
" My Custom Emacs-Style Move Shortcut
inoremap <C-Z> <S-Left>
inoremap <C-S> <S-Right>
" Delete/Cut forward word
inoremap <C-D> <C-O>dw
inoremap <C-K> <C-O>D
inoremap <C-W> <C-\><C-O>db
inoremap <C-U> <C-\><C-O>d0
inoremap <C-Y> <C-R>"
" Same as above, works for cmdline
" Additionaly you can use c-f to editing cmd in normal mode window
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-Z> <S-Left>
cnoremap <C-S> <S-Right>
cnoremap <C-D> <S-Right><C-W>
cnoremap <C-Y> <C-R>"
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal mode mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if v:version >= 801
    tnoremap <Esc> <c-\><c-n>
endif
" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pattern Match, Search Highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Normal mode pressing * or # searches for word under cursor
" enable * # for visual selected text, whitespace match any whitespace in potential result
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

" userful to redirect internal command output to paste buffer
func! Exec(command)
    redir =>output
    silent exec a:command
    redir END
    return output
endfunct!

" The function Nr2Bin() returns the binary string representation of a number.
function! Nr2Bin(nr)
    let n = a:nr
    let r = ""
    while n
        let r = '01'[n % 2] . r
        let n = n / 2
    endwhile
    return r
endfunc

function! TransBackground()
    hi Normal ctermbg=NONE guibg=NONE
    hi NonText ctermbg=NONE guibg=NONE
    hi clear CursorLine
    hi CursorLine gui=underline cterm=underline ctermfg=NONE guifg=NONE
endfunction

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

iab xdate  <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xdate2 <c-r>=strftime("%F")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""    SET VIM OPTIONS      """""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Set utf8 as standard encoding and en_US as the standard language
language en_US.utf8
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Work with longline
set display+=lastline
set breakat=" ^I!@*+;:,./?"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface element
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
set hidden
set confirm

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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autowrite
set mouse=a
set notimeout
set ttimeout
set timeoutlen=500 " For <leader> mapping
set ttimeoutlen=0  " No keycode dealy - no esc dealy
set scrolloff=0    " allow cursor to be at top and bottom
" set virtualedit=all "allow cursor to be anywhere

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Code Navigation - Cscope/LanguageClient
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set cscopequickfix=g-,s-,c-,f-,i-,t-,d-,e-
    " add any cscope database in current directory
    map <leader>ca :cs add <C-r>=getcwd()<cr>/cscope.out <C-r>=getcwd()<cr>
    " show msg when any other cscope db added
    set cscopeverbose
    " seach for definition
    map <leader>gd  :cs find g <c-r><c-w><cr>
    " search for this symbol
    map <leader>gs  :cs find s <c-r><c-w><cr>
    " find the file under the name
    map <leader>gf  :cs find f <c-r><c-p><cr>
    " search files that include this file
    map <leader>gi  :cs find i <c-r>=expand("%:t")<cr><cr>
    " egrep pattern matching
    map <leader>ge  :cs find e <c-r><c-w><cr>
    " Find assignments to this symbol
    map <leader>ga  :cs find a <c-r><c-w><cr>
    " search functions that call this function
    map <leader>gc  :cs find c <c-r><c-w><cr>
    " search this string
    map <leader>gt  :cs find t <c-r><c-w><cr>
endif

" nnoremap <silent> <leader>gk :LSClientShowHover<cr>
" nnoremap <silent> <leader>gd :LSClientGoToDefinition<cr>
nnoremap <silent> <leader>gr :LSClientFindReferences<cr>
" nnoremap <silent> <leader>gs :LSClientDocumentSymbol<cr>
" nnoremap <silent> <leader>gn :LSClientRename<cr>

"""""""""""""""""""""""""""""""""""""""""
"" Code/Text AutoFormat,AutoComplete
"""""""""""""""""""""""""""""""""""""""""
function! SetupCodeEnvironment()
    "set trigger for language-client's omnifunc
    if &filetype == 'c' || &filetype == 'cpp'
        if executable('cquery-clang-format')
            if empty(glob('~/.clang-format'))
                setlocal formatprg=cquery-clang-format\ --style='Webkit'
                setlocal equalprg=cquery-clang-format\ --style='Webkit'
            else
                setlocal formatprg=cquery-clang-format\ --style='file'
                setlocal equalprg=cquery-clang-format\ --style='file'
            endif
        endif
    elseif &ft  == 'javascript'
        if executable('js-beautify')
            " setlocal equalprg='js-beautify '
        endif
    elseif &ft  == 'python'
        if executable('pyls')
            setlocal makeprg=python\ %
            setlocal equalprg=autopep8\ --in-place\ --aggressive
        endif
    else
        setlocal formatprg=
        setlocal formatexpr=
        setlocal equalprg=
        setlocal omnifunc=
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => colors , fonts, display, highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
function! MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let s .= (i == t ? '%#TabNumSel#' : '%#TabNum#')
        let s .= ' ' . i . ' '
        let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
        let file = bufname(buflist[winnr - 1])
        let file = fnamemodify(file, ':t')
        let s .= ' ' . (file =='' ? '[No Name]' : file)
        let nwins = tabpagewinnr(i, '$')
        if nwins > 1
            let s .= ' ' . '(' . winnr . '/' . nwins . ')'
        endif
        let s .= i < tabpagenr('$') ? ' %#TabLine#|' : ' '
        let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#'
    return s
endfunction

function! DisplayReloadTheme()
    try 
        colorscheme sublimemonokai
    catch
        silent! colorscheme desert
    endtry
    " Set the Syntax
    syntax on
    set cursorline
    " set extra options when running in gui mode
    if has("gui_running")
        set guioptions-=t
        set guioptions-=e
        set guitablabel=%m\ %t
        set t_Co=256
    endif
    if $TERM  =~? '256color'
        set t_Co=256
        if v:version >= 800
            set termguicolors
        endif
    endif
    set number
    set foldcolumn=1
    " show hidden chars using shortcuts
    set listchars=tab:␉·,eol:␤,nbsp:▓
    set list
    " two highlight group nontext & specialkey for listchars
    highlight nontext ctermfg=238 guifg=#414141
    " override color scheme for the listchars "#649a9a
    highlight CursorLine guibg=#404040 gui=bold cterm=bold ctermbg=234
    highlight QuickFixLine term=reverse gui=reverse ctermbg=254 guibg=#000000
    " override Seach Highlight to make cursor more obvious
    highlight Search cterm=bold ctermbg=Brown ctermfg=White gui=bold guibg=Brown guifg=White
    " change cursor style dependent on mode
    if v:version >= 800
        if empty($tmux)
            let &t_si = "\<esc>]50;cursorshape=1\x7"
            let &t_ei = "\<esc>]50;cursorshape=0\x7"
            let &t_sr = "\<esc>]50;cursorshape=2\x7"
        else
            let &t_si = "\<esc>ptmux;\<esc>\<esc>]50;cursorshape=1\x7\<esc>\\"
            let &t_ei = "\<esc>ptmux;\<esc>\<esc>]50;cursorshape=0\x7\<esc>\\"
            let &t_sr = "\<esc>ptmux;\<esc>\<esc>]50;cursorshape=2\x7\<esc>\\"
        endif
    endif
    " Statusline
    set laststatus=2 "In order to show the lightline
    set showcmd      "Always print current keystroke
    set ruler        "Always show current position
    set cmdheight=1  "Height of the command bar
    set statusline=
    set statusline+=\ %(第%c列%) 
    set statusline+=\ %f\ %r%w         " filename and flags
    set statusline+=\ %(共%L行%) 
    set statusline+=%=%<               " force space and start cut if too long
    " set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight type on word
    set statusline+=\ [%{getcwd()}][%{&ft}]         " flags and filetype
    set statusline+=\ [UTF:%B]:%-04o\      " unicode under cursor && offset from start of file
    set tabline=%!MyTabLine()
    highlight Statusline cterm=bold ctermfg=59 ctermbg=235 gui=bold guifg=black guibg=#b0dfe5
    highlight StatusLineNC cterm=NONE ctermfg=239 ctermbg=59 gui=NONE guibg=#64645e guifg=#75715E
    " Tabline
    highlight TabLine cterm=NONE ctermfg=252 ctermbg=239 gui=NONE guifg=black guibg=#555555 
    highlight TabLineSel cterm=bold ctermfg=231 ctermbg=252 gui=bold guifg=red guibg=#36454F
    highlight TabLineFill cterm=bold ctermfg=243 ctermbg=239 gui=NONE guifg=#8F908A guibg=#555555
    " Customer User Color %1*text%0* 
    " highlight User1 cterm=NONE ctermfg=59 ctermfg=235 gui=bold guifg=red guibg=#b0dfe5
endfunction

call DisplayReloadTheme()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""    AUTO COMMANDS         """""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
    augroup myvimrc
        autocmd! *

        " Auto reload conffiguration file, clean whitespace for some common code files
        autocmd BufWritePost ~/.vimrc nested source ~/.vimrc | :call DisplayReloadTheme()
        autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()

        " Return to last edit position when opening files (You want this!)
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

        " Save the code folding if we had one
        " autocmd BufWinLeave * silent! mkview
        " autocmd BufWinEnter * silent! loadview

        " Properly disable sound on errors on MacVim
        if has("gui_macvim")
            autocmd GUIEnter * set vb t_vb=
        endif

        if v:version >= 800
            " auto save 
            autocmd TextChanged * let v:errmsg = '' | silent! write | if v:errmsg == '' | write | endif
            autocmd InsertLeave * let v:errmsg = '' | silent! write | if v:errmsg == '' | write | endif
            " Focus: only work in GUI or under tmux + vim-tmux-focus plugin
            " autocmd FocusGained * :call DisplayReloadTheme()
            " autocmd FocusLost   * :highlight Normal ctermbg=0 guibg=#101010
        endif

        " smart cursorline
        autocmd WinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline

        " tab special for makefile 
        autocmd FileType make setlocal noexpandtab tabstop=8 shiftwidth=8

        autocmd FileType * :call SetupCodeEnvironment()

    augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""    END OF VIM OPTIONS SETTING    """"""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists("g:gui_oni")
    augroup MYGROUP
        autocmd! FocusGained *
        autocmd! FocusLost *
    augroup END
endif

nohlsearch
