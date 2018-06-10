if (exists('g:repeatable_motions_use_default_mappings') && !g:repeatable_motions_use_default_mappings)
    finish
endif

let s:default_mappings = [
            \ { 'plug_mapping': 'RepeatMotionUp', 'default_mapping': '<C-k>' },
            \ { 'plug_mapping': 'RepeatMotionDown', 'default_mapping': '<C-j>' },
            \ { 'plug_mapping': 'RepeatMotionLeft', 'default_mapping': '<C-h>' },
            \ { 'plug_mapping': 'RepeatMotionRight', 'default_mapping': '<C-l>' },
            \ { 'plug_mapping': 'RepeatMostRecentMotion', 'default_mapping': 'g.' },
            \ { 'plug_mapping': 'ReverseMostRecentMotion', 'default_mapping': 'g:' }
            \]

for m in s:default_mappings
    if !hasmapto("<Plug>". m.plug_mapping, '')
        exe "map" m.default_mapping "<Plug>" . m.plug_mapping
    endif
endfor
