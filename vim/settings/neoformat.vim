" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" Use formatprg when available
let g:neoformat_try_formatprg = 1

"let g:neoformat_verbose = 1

let g:neoformat_enabled_scss = []
let g:neoformat_enabled_javascript = []
let g:neoformat_enabled_json = []
let g:neoformat_enabled_html = []

function! AutoFormat()
    let ftToUse = ['scss', 'json', 'html', 'tmpl', 'tmpl.html']

    if index(ftToUse, &ft) >= 0
        echom "Format non js file"
        Neoformat
    elseif &ft == "javascript"
        echom "Format javascript"
        let save_pos = getpos(".")
        normal gggqG
        call setpos(".", save_pos)
    else
        echom "Unknown format"
    endif
endfunction

" Run neoformat
nnoremap <silent> <Leader>s :call AutoFormat()<CR>
