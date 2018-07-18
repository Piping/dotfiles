
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
                \                 [ 'filename', 'readonly', 'modified', 'lineinfo','truncate_start', 'percent', ] ],
                \     'right' : [ [ 'bufnum' ], [ 'fileformat', 'filetype'], [ 'my_bufferlist','fileencoding', 'my_charvaluehex', 'charvalue' ], ]
                \  },
                \  'inactive': {
                \   'left': [ [ ] ],
                \   'right': [ ['bufnum'], [ 'relativepath', ] ]
                \  },
                \  'tabline': {
                \     'left': [ [ 'my_text','tabs' ], ],
                \     'right': [ [ 'vim_pwd', ] ]
                \  },
                \  'tab': {
                \     'active': [ 'tabnum', 'my_path' ],
                \     'inactive': [ 'tabnum', ],
                \  },
                \  'tabline_subseparator': {
                \     'left': '',
                \     'right': '',
                \  },
                \  'tab_component_function': {
                \     'my_path': 'LightlineTabShowPath',
                \  },
                \  'component': {
                \     'my_text': 'Tab:',
                \     'my_charvaluehex': 'U+%B',
                \     'truncate_start': '%<',
                \  },
                \  'component_function': {
                \     'normal_submode': 'ShowExtraNormalMode',
                \     'my_bufferlist': 'ShowCurrentBufferList',
                \     'vim_pwd': 'getcwd',
                \  },
                \  'component_visible_condition': {
                \     'truncate_start': 0,
                \     'tabs': 0,
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
    function! LightlineTabLineTheme()
        let g:lightline#colorscheme#default#palette.tabline.tabsel = [[ '#f62d6c', '#2d2e27', 252, 66, 'bold' ]]
        let g:lightline#colorscheme#default#palette.tabline.middle = [[ '#d0d0d0', '#2d2e27', 252, 66, 'bold' ]]
        let g:lightline#colorscheme#default#palette.tabline.right  = [[ '#606060', '#2d2e27', 252, 66, 'bold' ]]
        let g:lightline#colorscheme#default#palette.tabline.left   = [[ '#606060', '#2d2e27', 252, 66, 'bold' ]]
        let g:lightline#colorscheme#default#palette.inactive.right = [[ '#606060', '#202020', 252, 66, 'bold' ]]
        let g:lightline#colorscheme#default#palette.inactive.middle = [[ '#606060', '#000000', 252, 66, 'bold' ]]
    endfunction
    command! LightlineTabLineTheme call LightlineTabLineTheme()

    function! LightlineReload()
        if exists('*lightline#init')
            call lightline#init()
            call lightline#colorscheme()
            call lightline#update()
        endif
    endfunction
    command! LightlineReload call LightlineReload()

    function! LightlineTabShowPath(n)
        return expand('%:.')
    endfunction
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    Plug 'bling/vim-bufferline'
    let g:bufferline_echo = 0
    let g:bufferline_rotate = 0
    function! ShowCurrentBufferList()
        if empty(glob('~/.vim/plugged/vim-bufferline'))
            return
        endif
        call bufferline#refresh_status() 
        return g:bufferline_status_info.before.''
                    \ .'[正文]'
                    \ .g:bufferline_status_info.after
    endfunction
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    Plug 'mhinz/vim-startify'
    """"""""""""""""""""""""""""""

    """""""""""""""""""""""""""""
    Plug 'ErichDonGubler/vim-sublime-monokai'
    """"""""""""""""""""""""""""""

    """""""""""""""""""""""""""""" "On demand loading
    Plug 'chrisbra/Colorizer', { 'on': [ 'ColorHighlight', 'ColorToggle' ] }
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    Plug 'posva/vim-vue', { 'for': 'vue' }
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    if has( 'python' ) || has( 'python3' )
        Plug 'maralla/completor.vim' , {'on': 'CompletorEnable', 'for': 'vim,tmux,make,c,cpp,vue,js,html'}
        inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
        inoremap <expr> <Cr>    pumvisible() ? "\<C-y>" : "\<Cr>"
        inoremap <expr> <C-Y>   pumvisible() ? "\<C-y>" : '\<C-R>"'
    endif
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
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
    " Plug 'easymotion/vim-easymotion', {'on': [ '<Plug>(easymotion-sn)', '<Plug>(easymotion-prefix)', '<Plug>(easymotion-overwin-f)' ] }
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    Plug 'w0rp/ale', { 'on': [ 'ALENext', 'ALEPrevious', 'ALEEnable' ] , 'for': 'cpp,c,js,html' }
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    Plug 'junegunn/fzf', {'on': ['FZF','Ag','Commands','Commits', 'Buffers','History','Files']}
    Plug 'junegunn/fzf.vim' , {'on': ['FZF','Ag','Commands', 'Commits', 'Buffers','History','Files']}
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

    if exists('*nvim_open_float_win')
        function! FZF_Floating()
            let b = nvim_create_buf(v:false)
            call nvim_buf_set_option(b, "buftype", "nofile")
            let opts = {'x':0, 'y':5, 'anchor': 'NE'}

            let w =  nvim_open_float_win(b,v:true,&columns,&lines-10,opts)

            hi Floating guibg=#000000
            call setwinvar(w, '&winhl', 'Normal:Floating')
            call setwinvar(w, '&number', 0)
        endfunction
        let g:fzf_layout = { 'window': 'call FZF_Floating()' }
    else
        let g:fzf_layout = { 'up': '~70%' }
    endif
    " let $FZF_DEFAULT_COMMAND = 'find . -path ''*/\.*\'' -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//'
    let $FZF_DEFAULT_OPTS  = "--height 40% --bind ctrl-f:select-all,ctrl-g:deselect-all ".
                \ "--header ' :: Tip <C-t> Open in new tab;<C-x> Open in split;\n".
                \ " :: Tip <C-v> Open in vertical split;<Esc> or <C-d> Quit \n".
                \ " :: Tip <C-f> select_all; <C-g> deselect_all;<C-q> send_to_quickfix;' "
    """""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    " VIM's OPERATOR/TEXT OBJECT "
    """"""""""""""""""""""""""""""
    Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
    """"""""""""""""""""""""""""""
    " Plug 'michaeljsmith/vim-indent-object'
    """"""""""""""""""""""""""""""
    " Plug 'piping/vim-surround', { 'on': [ '<Plug>Dsurround', '<Plug>Ysurround', '<Plug>Csurround' ] }
    """"""""""""""""""""""""""""""
    Plug 'wellle/targets.vim'
    Plug 'benjifisher/matchit.zip'
    """"""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    Plug 'tmux-plugins/vim-tmux-focus-events'
    """"""""""""""""""""""""""""""

    call plug#end()
    "}} PLUGIN MANAGER END 
else
    command! LightlineReload :normal! zz 
endif

"""""""""""""""""""""""""""""""""""""""""
""PLUGIN LEADER KEY MAPPING"
"""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<space>"

"""""""""""""""""""""""""""""""""""""""""
""PLUGIN LEADER KEY MAPPING"
"""""""""""""""""""""""""""""""""""""""""
" Recently Used Files
" Overwrite default gf - open file under the cursor
nmap <leader>F    :FZF <C-r>=getcwd()<cr>
" map  <leader>fm   :Marks<Cr><C-w>l<C-w>=<C-w>h
" map  <leader>fg   :Ag 
" Recently Used Cmd, Alt-Enter to execute command
nmap <leader>ch   :History<Cr>
" Fuzzy Search ALL Vim Commands<C-w>l<C-w>=<C-w>h
nmap <leader>cc   :Commits<Cr>
nmap <leader>cm   :Commands<Cr>
" easy-alignment no argument go to interactive mode
vmap <leader>a    :EasyAlign
nmap <leader>u    :UndotreeToggle<Cr>:normal! zz<cr>
map  <leader>m    :TagbarToggle<cr>:wincmd = <cr>:normal! zz<cr>
nmap <silent>     <leader>z  :Goyo<cr>:normal! zz<cr>
nmap <nowait> gf  :call GoToFile()<cr>
map  gc           <Plug>Commentary
nmap gcc          <Plug>CommentaryLine

function! GoToFile()
    let v:errmsg = ""
    silent! normal! gf
    if v:errmsg == ""
        bprevious
        normal! vgf
    elseif exists(':FZF')
        " normal :FZF =getcwd()
        execute "normal! :FZF \<C-R>=getcwd()\<cr>\<cr>"
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""
"" All leader key mapping
"""""""""""""""""""""""""""""""""""""""""
" Repeat Last Macro
nnoremap <leader>. @@
"repeat last typed command
nnoremap <leader>; @:
" Go to Buffer
if v:version >= 800
    nmap <leader>b :ls<cr>:sbuffer
else
    nmap <leader>b :ls<cr>:buffer
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Vim Editor Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>l :silent! set list!<cr>

" set 'p' to paste before cursor
nnoremap p P
" swap cursro and next char
nnoremap P p

" swap cursor and previous char " xP

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
nmap <silent> <leader><cr> :noh<cr>

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
nnoremap [t gT

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""        Special Windows Shortcuts    """"""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quickfix window  displaying
let g:quickfix_opened = 0
map <expr> <leader>q   g:quickfix_opened == 0 ? ":botright copen<cr>:let g:quickfix_opened = 1<cr>" : ":cclose<cr>:let g:quickfix_opened = 0<cr>"

" Help Windows
if v:version >= 800
    map <leader>hc :helpclose<cr>
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

noremap <leader>r  :source $MYVIMRC<cr>
" utilize transparent background provoded by some terminals emulators like iTerm2

function! TransBackground()
    hi! Normal ctermbg=NONE guibg=NONE
    hi! NonText ctermbg=NONE guibg=NONE
    hi clear CursorLine
    hi CursorLine gui=underline cterm=underline ctermfg=NONE guifg=NONE
endfunction

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
            autocmd! *
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
        vnoremap h o
        vnoremap o i
        vnoremap i k
        vnoremap j h
        vnoremap k j
        vnoremap l l
        nnoremap h o
        nnoremap o i
        nnoremap i k
        nnoremap j h
        nnoremap k j
        nnoremap l l
    else
        let s:hjkl_compatiable_mode = 1
        vunmap h
        vunmap o
        vunmap i
        vunmap j
        vunmap k
        vunmap l
        nunmap o
        nunmap h
        nunmap i
        nunmap j
        nunmap k
        nunmap l
    endif
endfunction
nnoremap <leader>hj :call ToggleHJKLCompatiableMode()<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Zoomed Window
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nmap  <silent> <leader>z   :call ToggleOnlyWindow()<cr>:normal! zz<cr>
let s:zoomed_windows_b = 0
function! ToggleOnlyWindow()
    if s:zoomed_windows_b == 0
        let s:zoomed_windows_b = 1
        wincmd _ " slient call feedkeys('\<C-w>_')
        vertical resize 100
        normal! zz
    else
        let s:zoomed_windows_b = 0
        wincmd =
        normal! zz
    endif
endfunction
" mksession! ~/.vim/zoom_windows_layout_session_tmp.vim
" wincmd o "only windows

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" END of Leader Key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Extra Normal Mode Mapping 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap = to line end $, like it, easier to press and remember
noremap = $
noremap \ gg=G''
noremap <nowait> q ZQ

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
nmap <silent> [p :cp<cr>zz 
nmap <silent> ]p :cn<cr>zz
nmap <silent> [l :ALENext<cr>zz
nmap <silent> ]l :ALEPrevious<cr>zz

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
" => Code Development - Cscope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set cscopequickfix=g-,s-,c-,f-,i-,t-,d-,e-

    " add any cscope database in current directory
    map <leader>ca :cs add <C-r>=getcwd()<cr>/cscope.out <C-r>=getcwd()<cr>

    " show msg when any other cscope db added
    set cscopeverbose

    " Find assignments to this symbol
    map <leader>ga  :cs find a <c-r>=expand("<cword>")<cr><cr>zz:botright copen<cr><c-w>p
    " search for c symbol
    map <leader>gs  :cs find s <c-r>=expand("<cword>")<cr><cr>zz:botright copen<cr><c-w>p
    " seach for global definition
    map <leader>gg  :cs find g <c-r>=expand("<cword>")<cr><cr>zz:botright copen<cr><c-w>p
    " search functions that call this function
    map <leader>gc  :cs find c <c-r>=expand("<cword>")<cr><cr>zz:botright copen<cr><c-w>p
    " search this string
    map <leader>gt  :cs find t <c-r>=expand("<cword>")<cr><cr>zz:botright copen<cr><c-w>p
    " egrep pattern matching
    map <leader>ge  :cs find e <c-r>=expand("<cword>")<cr><cr>zz:botright copen<cr><c-w>p
    " search this file
    map <leader>gf  :cs find f <c-r>=expand("<cfile>")<cr><cr>zz:botright copen<cr><c-w>p
    " search files that include this file
    map <leader>gi  :cs find i <c-r>=expand("%:t")<cr><cr>zz:botright copen<cr><c-w>p
    " searcg files that inclde the filename under cursor
    map <leader>gn  :cs find i <c-r>=expand("<cfile>")<cr><cr>zz:botright copen<cr><c-w>p
    " search for functions are called by this function
    map <leader>gd  :cs find d <c-r>=expand("<cword>")<cr><cr>zz:botright copen<cr><c-w>p
endif


" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pattern Match, Search Highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Normal mode pressing * or # searches for word under cursor
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

"""""""""""""""""""""""""""""""""""""""""
"" Code/Text AutoFormat
"""""""""""""""""""""""""""""""""""""""""
function! SetAutoFormatProgram()
    if &filetype == 'c'
        if executable('clang-format')
            if empty(glob('~/.clang-format'))
                setlocal equalprg=clang-format\ --style='Webkit'
            else
                setlocal equalprg=clang-format\ --style='file'
            endif
        endif
    elseif &ft  == 'javascript'
        if executable('js-beautify')
            " setlocal equalprg='js-beautify '
        endif
    endif
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
set hidden

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
if v:version >= 800
    set switchbuf=useopen,usetab,vsplit
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
" => colors , fonts, display, highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! DisplayReloadTheme()
    try 
        colorscheme sublimemonokai
    catch
        silent! colorscheme desert
    endtry

    syntax on

    set cursorline

    :LightlineReload

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

    set nonumber
    set foldcolumn=1

    " show hidden chars using shortcuts
    set list
    set listchars=tab:␉·,eol:␤,nbsp:▓
    " two highlight group nontext & specialkey for listchars
    highlight nontext ctermfg=238 guifg=#414141
    " overrite color scheme for the listchars "#649a9a

    highlight CursorLine guibg=#404040 gui=bold cterm=bold ctermbg=234
    highlight QuickFixLine term=reverse ctermbg=235 guibg=#272727

    if v:version >= 800
        " change cursor style dependent on mode
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

    :nohlsearch

endfunction

call DisplayReloadTheme()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""    AUTO COMMANDS         """""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
    augroup MYGROUP
        autocmd! *
        " Apply my custom lightline theme
        autocmd VimEnter * silent! LightlineTabLineTheme

        " Auto reload conffiguration file, clean whitespace for some common code files
        autocmd BufWritePost ~/.vimrc nested source ~/.vimrc | :call DisplayReloadTheme()
        autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()

        " Return to last edit position when opening files (You want this!)
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

        " Save the code folding if we had one
        autocmd BufWinLeave * silent! mkview
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
            autocmd FocusGained * :call DisplayReloadTheme()
            autocmd FocusLost   * :highlight Normal ctermbg=0 guibg=#101010
        endif

        " smart cursorline
        autocmd WinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline

        " tab special for makefile 
        autocmd FileType make setlocal noexpandtab tabstop=8 shiftwidth=8

        autocmd FileType * :call SetAutoFormatProgram()
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

