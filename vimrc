set nocompatible

"fix backspace
set backspace=2
set grepprg=grep\ -nH\ $*

filetype off
syntax on

"" vundle related
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'Vim-R-plugin'
Bundle 'tpope/vim-surround'
Bundle 'vim-flake8'
Bundle 'scrooloose/nerdtree'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
Bundle 'JuliaLang/julia-vim'
Bundle 'kien/ctrlp.vim'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'lepture/vim-jinja'
Bundle 'loremipsum'
Bundle 'ervandew/supertab'
Bundle 'rodjek/vim-puppet'
Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-classpath'
Bundle 'tpope/vim-fugitive'
Bundle "paredit.vim"
Bundle 'ciaranm/inkpot'
Bundle 'lervag/vim-latex'
Bundle 'solars/github-vim'

filetype plugin indent on

"ctrlp ignore settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,vendor

nmap BB :BundleInstall<CR>
nmap BC :BundleClean<CR>

" paredit settings
let g:paredit_leader = '\'
let g:paredit_shortmaps = 1
let g:paredit_electric_return = 1

let maplocalleader = ';'

" "Sage settings (from Franco Saliola)
autocmd BufRead,BufNewFile *.sage,*.pyx,*.spyx set filetype=python
autocmd Filetype python set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType python set makeprg=sage\ -b\ &&\ sage\ -t\ %

imap ii <C-[>

" window switching
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" buffer switching
nnoremap <Right> :bn<CR>
nnoremap <Left> :bp<CR>

" don't respect wrapped lines
nnoremap j gj
nnoremap k gk

set wildmenu

"line width
set tw=79
set fo-=t
set colorcolumn=80
highlight ColorColumn ctermbg=232

set ls=2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smartcase
set showcmd
set autoindent
set spelllang=en_us
set encoding=utf-8
set ignorecase
set number
set hlsearch
set incsearch
set more
set scrolloff=5

" persistant undo
set undofile
set undodir=~/.vim/undo

"" open new splits below / to right of current split
set splitbelow
set splitright

"" disable R underscore hotkey
let vimrplugin_assign = 0

" R support for ctags
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
    \ }

" " paste mode toggle
set pastetoggle=<F10>

" NERDTree toggle
nmap <F7> :NERDTreeToggle<CR>

" write the current file with sudo
cmap w!! w !sudo tee %
cmap Wq wq

fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

" move cursor below target block after yanking in visual mode
vmap y y']

nnoremap <C-y> :CtrlPBuffer<CR>
set t_Co=256
set background=light
colorscheme inkpot

"" call flake8 on python save
autocmd BufWritePost *.py call Flake8()
"au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
au BufNewFile,BufRead *.jl set ft=julia
au BufNewFile,BufRead *.R set ft=r
au BufNewFile,BufRead *.pp set ft=puppet
autocmd BufWritePre *.clj,*.rb,*.py :call <SID>StripTrailingWhitespaces()
