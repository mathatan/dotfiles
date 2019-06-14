"mark syntax errors with :signs
let g:syntastic_enable_signs=1
"automatically jump to the error when saving the file
let g:syntastic_auto_jump=0
"show the error list automatically
let g:syntastic_auto_loc_list=1
"don't care about warnings
let g:syntastic_quiet_messages = {'level': 'warnings'}

" Default to eslint. If you need jshint, you can override this in
" ~/.vimrc.after
" let g:syntastic_javascript_checkers = ['eslint']

" I have no idea why this is not working, as it used to
" be a part of syntastic code but was apparently removed
" This will make syntastic find the correct ruby specified by mri
function! s:FindRubyExec()
    if executable("rvm")
        return system("rvm tools identifier")
    endif

    return "ruby"
endfunction

if !exists("g:syntastic_ruby_exec")
    let g:syntastic_ruby_exec = s:FindRubyExec()
endif

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_enable_signs=1
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_auto_loc_list=1

let g:syntastic_css_checkers = ['stylelint', 'scss-lint']
let g:syntastic_csslint_options = "--errors=empty-rules,display-property-grouping,ids,font-sizes,zero-units,vendor-prefix,gradients,import,compatible-vendor-prefixes,duplicate-properties,fallback-colors --warnings=none"
let g:syntastic_quiet_messages = {}
let g:syntastic_scss_checkers = ['stylelint', 'scss-lint']
let g:syntastic_scss_scss_lint_args = '-c ~/.scsslint.yml'

let g:syntastic_html_checkers = ['htmlhint', 'eslint']

let g:syntastic_html_htmlhint_args = '-c ~/.htmlhintrc'
