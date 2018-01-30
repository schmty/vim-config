set nocompatible
filetype off
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'kien/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'mustache/vim-mustache-handlebars'
Plug 'scrooloose/nerdtree'
Plug 'tomasr/molokai'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mxw/vim-jsx'
Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
Plug 'zchee/deoplete-jedi'
call plug#end()
filetype plugin indent on
syntax on
set relativenumber
set nu
set smartindent
set termguicolors
color solarized8
let g:airline_theme='solarized'
" change color background based on time of day
let hr = (strftime('%H'))
if hr >= 19
  set background=dark
  let g:airline_solarized_bg='dark'
elseif hr >= 8
  set background=light
  let g:airline_solarized_bg='light'
elseif hr >= 0
  set background=dark
  let g:airline_solarized_bg='dark'
endif
let g:gruvbox_contrast="hard"
set shiftwidth=2
set tabstop=2
set expandtab
map <Up> <NOP>
map <Down> <NOP>
map <Left> <NOP>
map <Right> <NOP>
imap <Up> <NOP>
imap <Down> <NOP>
imap <Left> <NOP>
imap <Right> <NOP>
nnoremap <CR> G
nnoremap <BS> gg
nmap H 0
nmap L $
vmap H 0
vmap L $
imap fd <Esc>
map j gj
map k gk
set backspace=indent,eol,start
set smartindent
set autoindent
let mapleader = "\<Space>"
nnoremap <Leader>x :x<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gpl :Gpull<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>w :w!<CR>
nnoremap <Leader>nt :NERDTree<CR>
nnoremap <Leader>sr :SyntasticReset<CR>
au FileType clojure nnoremap <Leader>e :Eval<CR>
" leader mappings for testing
nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
inoremap {<cr> {<cr>}<c-o>O
inoremap [<cr> [<cr>]<c-o>O
inoremap (<cr> (<cr>)<c-o>O
" leader mappings for copy and paste
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" function for html cursor positioning
function! Expander()
  let line   = getline(".")
  let col    = col(".")
  let first  = line[col-2]
  let second = line[col-1]
  let third  = line[col]
  if first ==# ">"
    if second ==# "<" && third ==# "/"
      return "\<CR>\<C-o>==\<C-o>O"
    else
      return "\<CR>"
    endif
  else
    return "\<CR>"
  endif
endfunction
inoremap <expr> <CR> Expander()
" disabling rope
let g:pymode_rope=0
" disabling automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" emmet stuff
let g:user_emmet_install_global = 0
au FileType html,css EmmetInstall
" all my file/language specific settings
au FileType html imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
au FileType html imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
au FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
au FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
au FileType scss noremap <buffer> <c-f> :call CSSBeautify()<cr>
au FileType javascript noremap <buffer> <c-f> :call JsBeautify()<cr>
au FileType java inoremap {<cr> {<cr>}<c-o>O<tab>
au FileType clojure let b:AutoPairs = {'(':')', '[':']', '{':'}', '"': '"', '`':'`'}
au FileType c setlocal tabstop=4 shiftwidth=4
" more javascript config
let g:used_javascript_libs = 'underscore,jquery,react,flux,jasmine,chai'
" no swap
set noswapfile
" Prevent replacing paste buffer on paste
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
set wrap
set nofoldenable
" Show matching brackets
set showmatch
" Ignore case when searching
set ignorecase
" Look for uppercase when searched
set smartcase
" highlight all search results
set hlsearch
set linebreak
set wrap
" setting ignores for ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|bower_components'
" whitespace stuff
autocmd BufWritePre * :%s/\s\+$//e
" quick command to create a new file
command -nargs=1 E execute('silent! !mkdir -p "$(dirname "<args>")"') <Bar> e <args>
" function for switching line number mode
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set nonumber
    set relativenumber
  endif
endfunc

nnoremap <Leader>nu :call NumberToggle()<CR>

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

let g:python_host_prog='/Users/jake/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog='/Users/jake/.pyenv/versions/neovim3/bin/python'
" test stuff
let test#strategy = 'neoterm'
" terminal stuff
set shell=/usr/local/bin/zsh
tnoremap <Leader>ee <C-\><C-n>
" more leaders
nnoremap <Leader>te <C-w>s <C-w><C-w> :resize 15<CR> :term<CR>
nnoremap <Leader>v :vertical resize -5<CR>
nnoremap <Leader>npm :T npm install<CR>
nnoremap <Leader>h :resize -5<CR>
nnoremap <Leader>qt <C-w><C-w> :q!<CR>
nnoremap <Leader>rc :e ~/.nvim/init.vim<CR>
nnoremap <Leader>rct :tabe ~/.nvimrc<CR>
" airline config
set laststatus=2
let g:airline_powerline_fonts=1
let python_highlight_all = 1
function! SwitchBackground()
  if(&bg == "dark")
    set background=light
  else
    set background=dark
  endif
endfunction
nnoremap <Leader>sl :call SwitchBackground()<CR>
let g:python_host_prog = "/usr/local/bin/python2"
" code folding stuff
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
" deoplete stuff
let g:deoplete#enable_at_startup = 1
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" tags stuff
set tags=./tags,tags;$HOME

" extra python syntax stuff
augroup python
    autocmd!
    autocmd FileType python
                \   syn keyword pythonFunction self
augroup end
