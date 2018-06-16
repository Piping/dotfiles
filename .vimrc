
" ███████╗██╗  ██╗   ██╗███╗   ███╗ █████╗ ███╗   ██╗
" ██╔════╝██║  ╚██╗ ██╔╝████╗ ████║██╔══██╗████╗  ██║
" █████╗  ██║   ╚████╔╝ ██╔████╔██║███████║██╔██╗ ██║
" ██╔══╝  ██║    ╚██╔╝  ██║╚██╔╝██║██╔══██║██║╚██╗██║
" ██║By   ███████╗██║   ██║ ╚═╝ ██║██║  ██║██║ ╚████║
" ╚═╝ROBIN╚══════╝╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝

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

" PLUGIN MANAGER START {

call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""
"" LIGHTLINE PLUGIN
""""""""""""""""""""""""""""""

Plug 'itchyny/lightline.vim'
set laststatus=2 "In order to show the lightline
set showcmd      "Always print current keystroke
set ruler        "Always show current position
set cmdheight=1  "Height of the command bar
let g:lightline = {
            \  'active': {
            \     'left'  : [ [ 'mode', 'normal_submode', 'paste' ] ,
            \                 [ 'filename', 'readonly', 'modified', 'lineinfo','truncate_start' ] ],
            \     'right' : [ [ 'bufnum' ], [ 'fileformat', 'filetype'], [ 'fileencoding', 'my_charvaluehex', 'charvalue' ], ]
            \  },
            \  'inactive': {
            \   'left': [ [ ] ],
            \   'right': [ ['bufnum'], [ 'relativepath', ] ]
            \  },
            \  'tabline': {
            \     'left': [ [ 'my_text','tabs' ],[ 'relativepath', ] ],
            \     'right': [ [ 'vim_pwd', ] ]
            \  },
            \  'tab': {
            \     'active': [ 'tabnum', ],
            \     'inactive': [ 'tabnum', ],
            \  },
            \  'tabline_separator': {
            \     'left': '',
            \     'right': '',
            \  },
            \  'component': {
            \     'my_text': 'Tab:',
            \     'my_charvaluehex': 'U+%B',
            \     'truncate_start': '%<',
            \  },
            \  'component_function': {
            \     'normal_submode': 'ShowExtraNormalMode',
            \     'vim_pwd': 'getcwd',
            \  },
            \  'component_visible_condition': {
            \     'truncate_start': 0,
            \  },
            \  'component_function_visible_condition': {
            \     'normal_submode': 0,
            \  },
            \  'component_type': {
            \     'normal_submode': 'raw',
            \     'truncate_start': 'raw',
            \  },
            \}

"the color scheme variable only available before VimEnter
"Tab_FG_Color,Tab_BG_Color
autocmd VimEnter *
            \ let g:lightline#colorscheme#default#palette.tabline.tabsel = [[ '#f62d6c', '#2d2e27', 252, 66, 'bold' ]] |
            \ let g:lightline#colorscheme#default#palette.tabline.middle = [[ '#d0d0d0', '#2d2e27', 252, 66, 'bold' ]] |
            \ let g:lightline#colorscheme#default#palette.tabline.right  = [[ '#606060', '#2d2e27', 252, 66, 'bold' ]] |
            \ let g:lightline#colorscheme#default#palette.tabline.left   = [[ '#606060', '#2d2e27', 252, 66, 'bold' ]] |
            \ let g:lightline#colorscheme#default#palette.inactive.right   = [[ '#606060', '#202020', 252, 66, 'bold' ]]

function! LightlineReload()
    if exists('*lightline#init')
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    endif
endfunction
command! LightlineReload call LightlineReload()
""""""""""""""""""""""""""""""
Plug 'mhinz/vim-startify'
""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""
Plug 'ErichDonGubler/vim-sublime-monokai'
"colorscheme sublimemonokai "cannot be set here, set it later
""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""" "On demand loading
Plug 'chrisbra/Colorizer', { 'on': [ 'ColorHighlight', 'ColorToggle' ] }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'posva/vim-vue', { 'for': 'vue' }
""""""""""""""""""""""""""""""

" Plug 'Piping/repeatable-motions'
" Read Source Code
Plug 'joeytwiddle/repmo.vim'

""""""""""""""""""""""""""""""
Plug 'majutsushi/tagbar',       {'on': 'TagbarToggle'}
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
nmap <leader>u :UndotreeToggle<Cr>
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)','EasyAlign']}

" Command Line Maunal
" Option name      	 Shortcut key    	 Abbreviated 	 Global variable
" filter           	 CTRL-F          	 [gv]/.*/
" left_margin      	 CTRL-L          	 l[0-9]+
" right_margin     	 CTRL-R          	 r[0-9]+
" stick_to_left    	 <Left>, <Right> 	 < or >
" ignore_groups    	 CTRL-G          	 ig\[.*\]    	 g:easy_align_ignore_groups
" ignore_unmatched 	 CTRL-U          	 iu[01]      	 g:easy_align_ignore_unmatched
" indentation      	 CTRL-I          	 i[ksdn]     	 g:easy_align_indentation
" delimiter_align  	 CTRL-D          	 d[lrc]      	 g:easy_align_delimiter_align
" align            	 CTRL-A          	 a[lrc*]*

""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'maralla/completor.vim'
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-Y>   pumvisible() ? "\<C-y>" : '\<C-R>"'
""""""""""""""""""""""""""""""

Plug 'easymotion/vim-easymotion', {'on': [ '<Plug>(easymotion-sn)', '<Plug>(easymotion-prefix)', '<Plug>(easymotion-overwin-f)' ] }
nmap <leader>m  <Plug>(easymotion-prefix)
map  f    <Plug>(easymotion-overwin-f)
noremap <c-f> f
map  <space>  <Plug>(easymotion-sn)

""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'skywind3000/asyncrun.vim', {'on' : [ 'AsyncRun' ]}
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'w0rp/ale', { 'on': 'ALEEnable', 'for': 'cpp,c,js,html' }
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'junegunn/limelight.vim', {'on': 'LimeLight'}
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
Plug 'junegunn/fzf', {'on': ['Ag','Commands','Buffers','History','Files']}
Plug 'junegunn/fzf.vim' , {'on': ['Ag','Commands','Buffers','History','Files']}
" CTRL-A CTRL-Q to select all and build quickfix list
" location list is similar to quickfix, specific to each window
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
endfunction
let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }
if $FZF_DEFAULT_COMMAND == ""
    let $FZF_DEFAULT_COMMAND = 'find . -path ''*/\.*\'' -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//'
endif
let $FZF_DEFAULT_OPTS  = "--height 40% --bind ctrl-f:select-all,ctrl-g:deselect-all ".
            \ "--header ' :: Tip <C-t>TabSplit <C-x>split <C-v>vsplit <Esc>/<C-d> Quit\n".
            \ " :: Tip <C-f>select_all <C-g>deselect_all <C-q>send_to_quickfix'"
"""""""""""""""""""""""""""""

" Plug 'tmux-plugins/vim-tmux-focus-events'

""""""""""""""""""""""""""""""
" VIM's OPERATOR/TEXT OBJECT "
""""""""""""""""""""""""""""""
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
""""""""""""""""""""""""""""""
Plug 'michaeljsmith/vim-indent-object'
""""""""""""""""""""""""""""""

call plug#end()

"PLUGIN MANAGER END } 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => YouCompleteMe Lazy Loading Support
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set this time here to quickly load the youcompleteme afterward
" set updatetime=100
"let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"function! LazyLoadingVariousPlugin()
"    call plug#load('YouCompleteMe') | call youcompleteme#Enable()
"    echo 'YouCompleteMe Lazy Loaded'
"    set updatetime=1000
"    augroup LazyLoading
"        autocmd!
"    augroup END
"endfunction

"augroup LazyLoading
"    autocmd CursorHold * silent! call LazyLoadingVariousPlugin()
"augroup END

"""""""""""""""""""""""""""""""""""""""""
""PLUGIN LEADER KEY MAPPING"
"""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
" nmap ,  <leader>

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
nmap <leader>cm  :Commands<Cr>
nnoremap q: <Esc>
" easy-alignment no argument go to interactive mode
vmap <leader>a   :EasyAlign
"""""""""""""""""""""""""""""""""""""""""
"" All leader key mapping
"""""""""""""""""""""""""""""""""""""""""
" Repeat Last Macro
nnoremap <leader>. @@
"repeat last typed command
nnoremap <leader>; @:
" Normal mode pressing * or # searches for the current selection

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Vim Editor Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast saving
nmap <leader>w   :w!<Cr>
nmap <leader>q   :q<Cr>
nmap <leader>qq  :q!<Cr>
nmap <leader>qa  :qa!<Cr>
nmap <leader>nn  :silent! Lexplore!<Cr>
" set 'p' to paste before cursor
nnoremap p P
nnoremap P p
"Join the line below with space
nnoremap <leader>j  J
" Reverse of J
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
" noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>e  :e! ~/.vimrc<cr>
map <leader>et :e! ~/.tmux.conf<cr>
map <leader>ez :e! ~/.zshrc<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""      Buffer, Tab, Window Management   """"""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>m  :TagbarToggle<cr>:wincmd = <cr>
map <leader>t  :tabnew<cr>
map <leader>tc :tabclose<cr>
nnoremap <leader>tt gT

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""        Special Windows Shortcuts    """"""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quickfix window  displaying
map <leader>cc :botright copen<cr>
map <leader>co :cclose<cr>
"Close Preview Windows
map <leader>po :pclose<cr>
" To go to the next/previous quickfix entry:
map <leader>n  :cn<cr>
map <leader>p  :cp<cr>
" To go to the next/previous quickfix list
map <leader>nc :cnewer<cr>
map <leader>pc :colder<cr>
" Help Windows
map <leader>h  :helpclose<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
"
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
            au CursorMovedI * let updaterestore=&updatetime | set updatetime=500
            au InsertEnter  * let updaterestore=&updatetime | set updatetime=2000
            au InsertLeave  * let &updatetime=updaterestore
        augroup END
        echohl ModeMsg | echo '-- NORMAL(AUTO-ESC) --' | echohl None
    endif
endfunction
let s:custom_mode_output = 0
function! ShowExtraNormalMode()
    let s:custom_mode_output = ''
    if s:hjkl_compatiable_mode != 1
        let s:custom_mode_output .= '[ijkl] '
    endif
    if s:auto_normal_mode != 0 && mode() == 'n'
        let s:custom_mode_output .= '[esc] '
    endif
    return s:custom_mode_output
endfunction
" I Use Auto-Normal Mode by Default
" silent call ToggleAutoNormalMode()
nnoremap <leader>hn :call ToggleAutoNormalMode()<cr>
let s:hjkl_compatiable_mode = 1
function! ToggleHJKLCompatiableMode()
    if s:hjkl_compatiable_mode == 1
        let s:hjkl_compatiable_mode = 0
        vnoremap h i
        vnoremap i k
        vnoremap j h
        vnoremap k j
        vnoremap l l
        nnoremap h i
        nnoremap i k
        nnoremap j h
        nnoremap k j
        nnoremap l l
    else
        let s:hjkl_compatiable_mode = 1
        vunmap h
        vunmap i
        vunmap j
        vunmap k
        vunmap l
        nunmap h
        nunmap i
        nunmap j
        nunmap k
        nunmap l
    endif
endfunction
nnoremap <leader>hj :call ToggleHJKLCompatiableMode()<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
" mksession! ~/.vim/zoom_windows_layout_session_tmp.vim
" wincmd o

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => InertMode/CMDline Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap = to line end $, like it, easier to press and remember
noremap = $
noremap \ %
noremap \\ gg=G''
" for practice vim way of operating
" noremap <up> <nop>
" noremap <down> <nop>
" noremap <left> <nop>
" noremap <right> <nop>


" Map _ to be reverse of -, move cursor one line upward and beginning of the word
" noremap _ ddkp
" InsertMode with Extra Emacs Shortcut Mapping
inoremap <C-A> <Home>
inoremap <C-E> <End>
" My Custom Emacs-Style Move Shortcut
inoremap <C-Z> <S-Left>
inoremap <C-X> <S-Right>
" Delete/Cut forward word
inoremap <C-D> <C-O>dw
inoremap <C-K> <C-O>D
inoremap <C-W> <C-\><C-O>db
inoremap <C-U> <C-\><C-O>d0
" inoremap <C-Y> <C-R>"
" Same as above, works for cmdline
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-Z> <S-Left>
cnoremap <C-X> <S-Right>
cnoremap <C-D> <S-Right><C-W>
cnoremap <C-K> <C-u>
cnoremap <C-Y> <C-r>"
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Code Development - Cscope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set cscopequickfix=g-,s-,c-,f-,i-,t-,d-,e-

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add the database pointed to by environment variable
    elseif $CSCOPE_DIR !=""
        cs add $CSCOPE_DIR/cscope.out $CSCOPE_DIR
    endif
    " show msg when any other cscope db added
    set cscopeverbose

    " search for c symbol
    map <leader>gs  :vertical scs find s <c-r>=expand("<cword>")<cr>:botright copen<cr>
    " seach for global definition
    map <leader>gg  :vertical scs find g <c-r>=expand("<cword>")<cr>:botright copen<cr>
    " search functions that call this function
    map <leader>gc  :vertical scs find c <c-r>=expand("<cword>")<cr>:botright copen<cr>
    " search this string
    map <leader>gt  :vertical scs find t <c-r>=expand("<cword>")<cr>:botright copen<cr>
    " egrep pattern matching
    map <leader>ge  :vertical scs find e <c-r>=expand("<cword>")<cr>:botright copen<cr>
    " search this file
    map <leader>gf  :vertical scs find f <c-r>=expand("<cfile>")<cr>:botright copen<cr>
    " search files that include this file
    map <leader>gii :vertical scs find i <c-r>=expand("<cfile>")<cr>:botright copen<cr>
    map <leader>gi  :vertical scs find i <c-r>=expand("%:t")    <cr>:botright copen<cr>
    " search for functions are called by this function
    map <leader>gd  :vertical scs find d <c-r>=expand("<cword>")<cr>:botright copen<cr>

endif


" Special Configuration
" augroup FastLeaderKeyInsertMode
"   autocmd!
"   au TextChangedI * if strcharpart(getline('.')[col('.') - 1:], 0, 1) == ',' | set timeoutlen=200 | end
"   au TextChangedI * set timeoutlen=0
" augroup END
" let query = input('Functions calling: ')
" " Search for selected text, forwards or backwards.
" Paste matching text of last search
" maygn`ap
" enable * # for visual selected text, whitespace match any whitespace in potential result
function! s:getSelectedText()
    let l:old_reg = getreg('"')
    let l:old_regtype = getregtype('"')
    norm gvy
    let l:ret = getreg('"')
    call setreg('"', l:old_reg, l:old_regtype)
    exe "norm \<Esc>"
    return l:ret
endfunction
vnoremap <silent> * :call setreg("/",substitute(<SID>getSelectedText(),'\_s\+', '\\_s\\+', 'g') )<Cr>n
vnoremap <silent> # :call setreg("?",substitute(<SID>getSelectedText(),'\_s\+', '\\_s\\+', 'g') )<Cr>n

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pattern Match, Search Highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""    AUTO COMMANDS         """""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("autocmd")
    autocmd! BufWritePost ~/.vimrc nested source ~/.vimrc | LightlineReload
    " Return to last edit position when opening files (You want this!)
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    autocmd CursorHold * :call feedkeys('mz')
    
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
    
    autocmd BufWinLeave * silent! mkview
    autocmd BufWinEnter * silent! loadview
endif

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
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac
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

set cursorline
highlight cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#303000 ctermbg=234

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors , Fonts, Display
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
silent! colorscheme sublimemonokai
" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
else
    set termguicolors
endif

set nonumber
set foldcolumn=1
" highlight
" Show Hidden Chars
set list
set listchars=tab:>-,eol:ː,nbsp:▓
" Overrite Color Scheme for the listchars "#649A9A
" Two highlight group NonText & SpecialKey

" Change cursor style dependent on mode
if empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
endif

highlight NonText ctermfg=238 guifg=#414141
" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
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

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

set autowrite
set mouse=a
set ttymouse=xterm2 "| if $TMUX=="" | set ttymouse=xterm | endif
set timeout
set ttimeout
set timeoutlen=300 " For <leader> mapping
set ttimeoutlen=0 " No keycode delay
set scrolloff=0 "allow cursor to be at top and bottom
" set virtualedit=all "allow cursor to be anywhere

"""""""""""""""""""""""""""""""""""""""""
"" Code/Text AutoFormat
"""""""""""""""""""""""""""""""""""""""""
if executable('clang-format')
    set equalprg="clang-format --style=Webkit"
endif
" autocmd FileType javascript setlocal equalprg='js-beautify -f -'

set splitright
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""    END OF VIM OPTIONS SETTING    """"""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


