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
Bundle 'vim-scripts/HTML-AutoCloseTag'
Bundle 'tpope/vim-surround'
Bundle 'vim-flake8'
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
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-classpath'
Bundle 'tpope/vim-fugitive'
Bundle "paredit.vim"
Bundle 'ciaranm/inkpot'
Bundle 'lervag/vim-latex'
Bundle 'solars/github-vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'altercation/vim-colors-solarized'
Bundle 'sickill/vim-sunburst'
Bundle 'morhetz/gruvbox'
Bundle 'hynek/vim-python-pep8-indent'

filetype plugin indent on

"ctrlp ignore settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,vendor

nmap BB :BundleInstall<CR><CR>
nmap BC :BundleClean<CR><CR>

" paredit settings
let g:paredit_leader = '\'
let g:paredit_shortmaps = 1
let g:paredit_electric_return = 2

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

" write the current file with sudo
cmap w!! w !sudo tee > /dev/null %
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
set background=dark
colorscheme inkpot
set background=light
"colorscheme morning
"colorscheme solarized

" vim clojure indent settings for emacs compatibility
let g:clojure_align_multiline_strings = 1
let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let']

"" call flake8 on python save
autocmd BufWritePost *.py call Flake8()

"" fugitive bindings
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gc :Gcommit -v -q<CR>
nnoremap <space>gt :Gcommit -v -q %:p<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>gp :Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>
nnoremap <space>gps :Dispatch! git push<CR>
nnoremap <space>gpl :Dispatch! git pull<CR>

au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
au BufNewFile,BufRead *.jl set ft=julia
au BufNewFile,BufRead *.R set ft=r
au BufNewFile,BufRead *.pp set ft=puppet
au BufNewFile,BufRead *.scala set ft=scala
au BufRead,BufNewFile *.md,*.markdown,*.tex setlocal fo+=t
autocmd BufWritePre *.clj,*.rb,*.py :call <SID>StripTrailingWhitespaces()
