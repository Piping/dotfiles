" File: repeatable-motions.vim
" Author: Mohammed Chelouti <mhc23 at web dot de>
" Description: Plugin that makes many motions repeatable
" Last Modified: Jul 14, 2017

if exists('g:loaded_repeatable_motions') || !has('eval')
    finish
endif
if !exists('g:repeatable_motions_use_default_mappings')
    let g:repeatable_motions_use_default_mappings = 1
endif
let g:loaded_repeatable_motions = 1

let s:repeatable_motions = []
let s:previous_columnwise_motion = ''
let s:previous_linewise_motion = ''
let s:most_recent_motion = ''

let s:tf_target = ''
let s:repeating = 0
let g:linewise_motion_repeating = 0
let g:columnwise_motion_repeating = 0

let s:FALSE = 0
let s:TRUE = !s:FALSE
let s:axes = {
            \ 'LINEWISE': 'axis/linewise',
            \ 'COLUMNWISE': 'axis/columnwise',
            \ 'PREVIOUS': ''
            \ }

let s:directions = {
            \ 'FORWARDS': 'direction/forwards',
            \ 'BACKWARDS': 'direction/backwards',
            \ 'PREVIOUS': '',
            \ 'REVERSE_PREVIOUS': ''
            \ }

function! s:RepeatMotion(axis, direction)
    let stand_still_motion = ''
    let is_valid_axis = a:axis == s:axes.LINEWISE ||
                \ a:axis == s:axes.COLUMNWISE
    let is_valid_direction = a:direction == s:directions.FORWARDS ||
                \ a:direction == s:directions.BACKWARDS

    if !is_valid_direction || !is_valid_direction
        return stand_still_motion
    endif

    let is_linewise_repetition = a:axis == s:axes.LINEWISE
    let is_forwards_repetition = a:direction == s:directions.FORWARDS
    let motion_object = is_linewise_repetition ?
                \ s:GetMotionObject(s:previous_linewise_motion) :
                \ s:GetMotionObject(s:previous_columnwise_motion)
    let has_motion_object = type(motion_object) == type({})

    if !has_motion_object
        return stand_still_motion
    endif

    let s:repeating = s:TRUE

    let direction_as_number = is_forwards_repetition ? 1 : -1
    " Set the varaiable linewise/columnwise_motion_repeating to 1 or -1, so we don't break API
    " compatibility for user defined functions that rely on those values
    if is_linewise_repetition
        let g:linewise_motion_repeating = direction_as_number
    else
        let g:columnwise_motion_repeating = direction_as_number
    endif

    let motion_keys = is_forwards_repetition ?
                \ s:Move(motion_object.forwards.lhs, s:FALSE) :
                \ s:Move(motion_object.backwards.lhs, s:FALSE)

    let g:linewise_motion_repeating = s:FALSE
    let g:columnwise_motion_repeating = s:FALSE
    let s:repeating = s:FALSE

    return motion_keys
endfunction

function! s:Move(motion, replace_most_recent_motion)
    let direction = s:GetMotionDirection(a:motion)
    let motion_object = s:GetMotionObject(a:motion)

    if a:replace_most_recent_motion
        call s:SetMostRecentMotion(a:motion)
    endif

    let is_forwards_motion = direction == s:directions.FORWARDS
    let direction_key = is_forwards_motion ? 'forwards' : 'backwards'

    if motion_object[direction_key].expr
        return eval(motion_object[direction_key].rhs)
    else
        let keys = s:MakeKeysFeedable(motion_object[direction_key].rhs)
        return keys
    endif

endfunction

function! s:SetMostRecentMotion(motion)
    let motion_object = s:GetMotionObject(a:motion)
    let direction = s:GetMotionDirection(a:motion)


    let s:directions.PREVIOUS = direction
    let s:directions.REVERSE_PREVIOUS = direction == s:directions.FORWARDS ?
                \ s:directions.BACKWARDS :
                \ s:directions.FORWARDS

    if motion_object.linewise
        let s:previous_linewise_motion = s:NormalizeMotion(a:motion)
        let s:axes.PREVIOUS = s:axes.LINEWISE
    else
        let s:previous_columnwise_motion = s:NormalizeMotion(a:motion)
        let s:axes.PREVIOUS = s:axes.COLUMNWISE
    endif

    let s:most_recent_motion = s:NormalizeMotion(a:motion)
endfunction

function! s:MakeKeysFeedable(keystrokes)
    let m = escape(a:keystrokes, '\')
    let m = escape(m, '"')
    let specialChars = [
                \ "<BS>",      "<Tab>",     "<FF>",         "<t_",
                \ "<CR>",      "<Return>",  "<Enter>",      "<Esc>",
                \ "<Space>",   "<lt>",      "<Bslash>",     "<Bar>",
                \ "<Del>",     "<CSI>",     "<xCSI>",       "<EOL>",
                \ "<Up>",      "<Down>",    "<Left>",       "<Right>",
                \ "<F",        "<Help>",    "<Undo>",       "<Insert>",
                \ "<Home>",    "<End>",     "<PageUp>",     "<PageDown>",
                \ "<kHome>",   "<kEnd>",    "<kPageUp>",    "<kPageDown>",
                \ "<kPlus>",   "<kMinus>",  "<kMultiply>",  "<kDivide>",
                \ "<kEnter>",  "<kPoint>",  "<k0>",         "<S-",
                \ "<C-",       "<M-",       "<A-",          "<D-"
                \]
    for s in specialChars
        let m = substitute(m, '\('.s.'\)', '\\\1', 'g')
    endfor

    silent exe 'return "'.m.'"'
endfunction

" backwards: {lhs} of the mapping to move the cursor backwards
" forwards: {lhs} of the mapping to move the cursor forwards
" linewise: if 1 the motion will be repeated vertically, otherwise horizontally
function! AddRepeatableMotion(backwards, forwards, linewise)
    let motionPair = { 'linewise': a:linewise }
    let defaultMaparg = { 'mode': '', 'noremap': 1, 'buffer': 0, 'silent': 0, 'expr': 0, 'nowait': 0 }
    let buffer = 0
    let mapstring = 'noremap <expr>'

    let maparg = maparg(a:backwards, '', 0, 1)
    if !empty(maparg)
        let motionPair.backwards = maparg
        if maparg.buffer
            let mapstring .= ' <buffer>'
        endif

        if maparg.silent
            let mapstring .= ' <silent>'
        endif
    else
        let motionPair.backwards = deepcopy(defaultMaparg)
        let motionPair.backwards.lhs = a:backwards
        let motionPair.backwards.rhs = a:backwards
    endif

    let maparg = maparg(a:forwards, '', 0, 1)
    if !empty(maparg)
        let motionPair.forwards = maparg
    else
        let motionPair.forwards = deepcopy(defaultMaparg)
        let motionPair.forwards.lhs = a:forwards
        let motionPair.forwards.rhs = a:forwards
    endif

    let backwards_escaped = "'".substitute(a:backwards, "'", "''", 'g')."'"
    let forwards_escaped = "'".substitute(a:forwards, "'", "''", 'g')."'"
    exe mapstring a:backwards '<SID>Move('.backwards_escaped.', '.s:TRUE.')'
    exe mapstring a:forwards '<SID>Move('.forwards_escaped.', '.s:TRUE.')'

    let targetList = s:repeatable_motions

    if motionPair.backwards.buffer || motionPair.forwards.buffer
        if !motionPair.backwards.buffer || !motionPair.forwards.buffer
            echoerr motionPair.backwards.lhs 'and' motionPair.forwards 'must be buffer or global mappings'
            return
        endif
        let targetList = b:repeatable_motions
    endif

    for m in targetList
        if m.backwards.lhs ==# a:backwards || m.forwards.lhs ==# a:forwards
            echoerr ''''.m.backwards.lhs ':' m.forwards.lhs.''' already defined'
            return
        endif
    endfor

    call add(targetList, motionPair)
endfunction

function! RemoveRepeatableMotion(motion)
    let motion = s:NormalizeMotion(a:motion)
    let motion = substitute(motion, '<Leader>', g:mapleader, 'g')
    let object = s:GetMotionObject(motion)
    let lists = [s:repeatable_motions]

    if type(object) != type({})
        return
    endif

    if exists('b:repeatable_motions')
        call insert(lists, b:repeatable_motions)
    endif

    for l in lists
        let i = 0
        for m in l
            if m.backwards.lhs == object.backwards.lhs
                for dir in ['backwards', 'forwards']

                    if m[dir].lhs ==# m[dir].rhs
                        if m[dir].buffer
                            exe 'bufdo unmap <buffer>' m[dir].lhs
                        else
                            exe 'unmap' m[dir].lhs
                        endif

                    else
                        if m[dir].noremap
                            let mapString = 'noremap'
                        else
                            let mapString = 'map'
                        endif

                        if m[dir].buffer
                            let mapString .= ' <buffer>'
                        endif

                        if m[dir].silent
                            let mapString .= ' <silent>'
                        endif

                        if m[dir].expr
                            let mapString .= ' <expr>'
                        endif
                    endif

                endfor

                call remove(l, i)
                break
            endif
            let i += 1
        endfor
    endfor
endfunction

function! s:GetMotionObject(motion)
    let lists = [s:repeatable_motions]
    if exists('b:repeatable_motions')
        call insert(lists, b:repeatable_motions)
    endif

    for l in lists
        for m in l
            if s:NormalizeMotion(m.backwards.lhs) ==# s:NormalizeMotion(a:motion)
                        \ || s:NormalizeMotion(m.forwards.lhs) ==# s:NormalizeMotion(a:motion)
                return m
            endif
        endfor
    endfor
endfunction

function! s:IsBufferMotion(motionObject)
    return motionObject.backwards.buffer
endfunction

function! GetPreviouslyPerformedMotion(linewise)
    if a:linewise
        let motionObject = s:GetMotionObject(s:previous_linewise_motion)
    else
        let motionObject = s:GetMotionObject(s:previous_columnwise_motion)
    endif

    if type(motionObject) != type({})
        unlet! motionObject
        let motionObject = {}
    endif

    return motionObject
endfunction

function! s:ListMotions()
    let linewiseMotions = []
    let columnwiseMotions = []
    for l in [s:repeatable_motions, b:repeatable_motions]
        for m in l
            let text = ''

            if l == b:repeatable_motions
                let text = '<buffer> '
            endif

            let text .= m.backwards.lhs

            let text .= ' : '.m.forwards.lhs

            if m.linewise
                if m.backwards.lhs ==# s:previous_linewise_motion || m.forwards.lhs ==# s:previous_linewise_motion
                    let text = '* '.text
                endif
                call add(linewiseMotions, "  " . text)
            else
                if m.backwards.lhs ==# s:previous_columnwise_motion || m.forwards.lhs ==# s:previous_columnwise_motion
                    let text = '* '.text
                endif
                call add(columnwiseMotions, "  " . text)
            endif
        endfor
    endfor

    unlet! m

    echo "Linewise motions"
    if empty(linewiseMotions)
        echo "  no repeatable linewise motions"
    else
        for m in linewiseMotions
            echo m
        endfor
    endif

    echo "Columnwise motions"
    if empty(columnwiseMotions)
        echo "  no repeatable columnwise motions"
    else
        for m in columnwiseMotions
            echo m
        endfor
    endif
endfunction

function! s:GetMotionDirection(motion)
    let motion_object = s:GetMotionObject(a:motion)

    let is_forwards_motion =
                \ s:NormalizeMotion(a:motion) ==# s:NormalizeMotion(motion_object.forwards.lhs)

    return is_forwards_motion ?
                \ s:directions.FORWARDS :
                \ s:directions.BACKWARDS
endfunction

" t/T and f/F are special motions and need this workaround to be easily repeatable
function! s:TFWorkaround(motion)
    if !g:columnwise_motion_repeating
        let s:tf_target = nr2char(getchar())
        let s:tf_motion = a:motion
        return a:motion . s:tf_target
    else
        return (s:tf_motion ==# a:motion) ? ';' : ','
    endif
endfunction

function! s:NormalizeMotion(motion)
    let result = substitute(a:motion, '<\ze[^>]\+>', '\\<', 'g')
    exe 'return "'. result . '"'
endfunction

if !exists('g:tf_workaround')
    let g:tf_workaround = 1
endif

function! s:ReverseMostRecentMotion()
    return s:RepeatMotion(s:axes.PREVIOUS, s:directions.REVERSE_PREVIOUS)
endfunction

function! s:RepeatMostRecentMotion()
    return s:RepeatMotion(s:axes.PREVIOUS, s:directions.PREVIOUS)
endfunction

let s:default_mappings = [
            \ {'bwd': '{', 'fwd': '}', 'linewise': 1},
            \ {'bwd': '[[', 'fwd': ']]', 'linewise': 1},
            \ {'bwd': '[c', 'fwd': ']c', 'linewise': 1},
            \ {'bwd': '[m', 'fwd': ']m', 'linewise': 1},
            \ {'bwd': '[M', 'fwd': ']M', 'linewise': 1},
            \ {'bwd': '[*', 'fwd': ']*', 'linewise': 1},
            \ {'bwd': '[/', 'fwd': ']/', 'linewise': 1},
            \ {'bwd': '[]', 'fwd': '][', 'linewise': 1},
            \ {'bwd': '[''', 'fwd': ']''', 'linewise': 1},
            \ {'bwd': '[`', 'fwd': ']`', 'linewise': 1},
            \ {'bwd': '[(', 'fwd': '])', 'linewise': 1},
            \ {'bwd': '[{', 'fwd': ']}', 'linewise': 1},
            \ {'bwd': '[#', 'fwd': ']#', 'linewise': 1},
            \ {'bwd': '[z', 'fwd': ']z', 'linewise': 1},
            \ {'bwd': 'zk', 'fwd': 'zj', 'linewise': 1},
            \ {'bwd': '(', 'fwd': ')', 'linewise': 0},
            \ {'bwd': '[s', 'fwd': ']s', 'linewise': 0}
            \ ]

command ListRepeatableMotions call <SID>ListMotions()

exe "noremap <script> <expr> <silent> <Plug>RepeatMotionUp <SID>RepeatMotion('".s:axes.LINEWISE."','".s:directions.BACKWARDS."')"
exe "noremap <script> <expr> <silent> <Plug>RepeatMotionDown <SID>RepeatMotion('".s:axes.LINEWISE."','".s:directions.FORWARDS."')"
exe "noremap <script> <expr> <silent> <Plug>RepeatMotionLeft <SID>RepeatMotion('".s:axes.COLUMNWISE."','".s:directions.BACKWARDS."')"
exe "noremap <script> <expr> <silent> <Plug>RepeatMotionRight <SID>RepeatMotion('".s:axes.COLUMNWISE."','".s:directions.FORWARDS."')"
noremap <script> <expr> <silent> <Plug>RepeatMostRecentMotion <SID>RepeatMostRecentMotion()
noremap <script> <expr> <silent> <Plug>ReverseMostRecentMotion <SID>ReverseMostRecentMotion()

if g:tf_workaround
    noremap <script> <expr> <silent> t <SID>TFWorkaround('t')
    noremap <script> <expr> <silent> T <SID>TFWorkaround('T')
    noremap <script> <expr> <silent> f <SID>TFWorkaround('f')
    noremap <script> <expr> <silent> F <SID>TFWorkaround('F')

    call add(s:default_mappings, {'bwd': 'F', 'fwd': 'f', 'linewise': 0})
    call add(s:default_mappings, {'bwd': 'T', 'fwd': 't', 'linewise': 0})
endif

for m in s:default_mappings
    call AddRepeatableMotion(m.bwd, m.fwd, m.linewise)
endfor

autocmd BufReadPost *
            \ let b:repeatable_motions = [] |
            \ for m in s:repeatable_motions |
            \   let bmapargs = maparg(m.backwards.lhs, '', 0, 1) |
            \   let fmapargs = maparg(m.forwards.lhs, '', 0, 1) |
            \   if bmapargs.buffer || fmapargs.buffer |
            \      call AddRepeatableMotion(m.backwards.lhs, m.forwards.lhs, m.linewise) |
            \   endif |
            \ endfor |
