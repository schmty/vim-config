let os = substitute(system('uname'), "\n", "", "")
if os == "Darwin"
    set guifont=Ubuntu\ Mono:h14
elseif os == "Linux"
    set gfn=Ubuntu\ Mono\ 13
    set guioptions-=T
    set guioptions-=m
    vmap <C-c> "+yi
    vmap <C-x> "+c
    vmap <C-v> c<ESC>"+p
    imap <C-v> <C-r><C-o>+
endif
