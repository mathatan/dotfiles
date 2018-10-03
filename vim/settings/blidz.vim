if $BLIDZPATH
    let g:blidzPath = $BLIDZPATH
el
    let g:blidzPath = split(getcwd(), 'blidz-client')[0] . "blidz-client"
endif

command Cdjs execute 'cd' fnameescape(g:blidzPath . "/client/www/js")
command Cdscss execute 'cd' fnameescape(g:blidzPath . "/client/www/res/scss")
command Cdtemplates execute 'cd' fnameescape(g:blidzPath . "/client/www/res/templates")
command Cdscripts execute 'cd' fnameescape(g:blidzPath . "/scripts")
command Cdwww execute 'cd' fnameescape(g:blidzPath . "/www")

cnoreabbr cdjs Cdjs
cnoreabbr cdscss Cdscss
cnoreabbr cdtemplates Cdtemplates
cnoreabbr cdtmpl Cdtemplates
cnoreabbr cdscripts Cdscripts
cnoreabbr cdwww Cdwww
