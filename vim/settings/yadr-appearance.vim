" Make it beautiful - colors and fonts

if has("gui_running") && !has("nvim")
  "tell the term has 256 colors
  set t_Co=256

  " Show tab number (useful for Cmd-1, Cmd-2.. mapping)
  " For some reason this doesn't work as a regular set command,
  " (the numbers don't show up) so I made it a VimEnter event
  autocmd VimEnter * set guitablabel=%N:\ %t\ %M

  set lines=60
  set columns=190

  if has("gui_gtk2")
    set guifont=Inconsolata\ XL\ 12,Inconsolata\ 12,Monaco\ 12
  else
    set guifont=Inconsolata-dz_for_Powerline:h12:cANSI:qDRAFT,Inconsolata:h12,Monaco:h12
  end

  colorscheme solarized
  set background=dark
else
  let g:CSApprox_loaded = 1

  set background=dark

  " For people using a terminal that is not Solarized
  " if exists("g:yadr_using_unsolarized_terminal")
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  " end
endif

" if !has("nvim")
"     colorscheme solarized
"     set t_Co=256
"     let g:solarized_termcolors=256
"     let g:solarized_termtrans=1
" endif

" if has("nvim")
"     set t_Co=16
"     colorscheme solarized
"     set background=dark
"     let g:solarized_termcolors=256
"     let g:solarized_termtrans=1
" endif

" if has("gui_vimr")
    " colorscheme solarized
    " set background=dark
    " let g:solarized_termcolors=256
    " let g:solarized_termtrans=1
" endif

