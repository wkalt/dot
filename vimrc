set nocompatible

" vundle related
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'chase/vim-ansible-yaml'
Bundle 'ciaranm/inkpot'
Bundle 'derekwyatt/vim-scala'
Bundle 'ervandew/supertab'
Bundle 'fatih/vim-go'
Bundle 'garbas/vim-snipmate'
Bundle 'hashivim/vim-terraform'
Bundle 'heavenshell/vim-jsdoc'
Bundle 'honza/vim-snippets'
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'jamessan/vim-gnupg'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'JuliaLang/julia-vim'
Bundle 'junegunn/fzf'
Bundle 'junegunn/fzf.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'lepture/vim-jinja'
Bundle 'lervag/vim-latex'
Bundle 'loremipsum'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'morhetz/gruvbox'
Bundle 'pangloss/vim-javascript'
Bundle 'paredit.vim'
Bundle 'rgrinberg/vim-ocaml'
Bundle 'rodjek/vim-puppet'
Bundle 'rust-lang/rust.vim'
Bundle 'solars/github-vim'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-classpath'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'vim-flake8'
Bundle 'Vim-R-plugin'
Bundle 'vim-scripts/HTML-AutoCloseTag'
Bundle 'w0rp/Ale'

filetype plugin indent on
syntax on
set wildmenu

" colorscheme
set t_Co=256
set background=dark
silent! colorscheme inkpot

" local leader
let maplocalleader = ';'

" fix backspace
set backspace=2
set grepprg=grep\ -nH\ $*

" vundle hotkeys
nmap BB :BundleInstall<CR><CR>
nmap BC :BundleClean<CR><CR>

" paredit settings
let g:paredit_leader = '\'
let g:paredit_shortmaps = 1
let g:paredit_electric_return = 2

" arrow keys for buffer switching
nnoremap <Right> :bn<CR>
nnoremap <Left> :bp<CR>

" don't respect wrapped lines
nnoremap j gj
nnoremap k gk

" line width / indenting
set tw=79
set fo-=t
set ls=2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set autoindent

" gray line at 80 characters
set colorcolumn=80
highlight ColorColumn ctermbg=232

" convert tabs to spaces
set expandtab

" search behavior - case-sensitive if search contains upper case
set smartcase
set ignorecase
set hlsearch
set incsearch

" display commands in lower right
set showcmd

" spell checking
set spelllang=en_us
set encoding=utf-8

" display line numbers
set number
set more

" keep cursor five spaces from bottom of screen when scrolling
set scrolloff=5

" persistant undo
set undofile
set undodir=~/.vim/undo

" open new splits below / to right of current split
set splitbelow
set splitright

" disable R underscore hotkey
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

" F10 paste mode toggle
set pastetoggle=<F10>

" write the current file with sudo
cmap w!! w !sudo tee > /dev/null %

" strip trailing whitespace fn
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

" move cursor below target block after yanking in visual mode
vmap y y']

nnoremap <C-p> :Files<CR>

" vim clojure indent settings for emacs compatibility
let g:clojure_align_multiline_strings = 1
let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let']

" call flake8 on python save
autocmd BufWritePost *.py call Flake8()

" indent function args in C++
set cino+=(0

let g:ale_linters = {
      \ 'go': ['gopls'],
      \}

" Ale
let b:ale_fixers = [
            \ 'remove_trailing_lines',
            \ 'isort',
            \ 'ale#fixers#generic_python#BreakUpLongLines',
            \ 'yapf',
            \ 'eslint',
            \]
nnoremap <buffer> <silent> <LocalLeader>= :ALEFix<CR>

" JsDoc
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1

" terraform
let g:terraform_align=1

" filetype-specific config
autocmd FileType clojure nmap <buffer> <Tab> :%Eval<CR>
autocmd FileType tex nmap <buffer> <Tab> :!pdflatex %<CR>

" filetype detection
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
au BufNewFile,BufRead *.rs set ft=rust
au BufNewFile,BufRead *.jl set ft=julia
au BufNewFile,BufRead *.tf set ft=terraform
au BufNewFile,BufRead *.R set ft=r
au BufNewFile,BufRead *.pp set ft=puppet
au BufNewFile,BufRead *.scala set ft=scala
au BufRead,BufNewFile *.md,*.markdown,*.tex setlocal fo+=t

" filetype behavior on write
autocmd BufWritePre *.clj,*.rb,*.py :call <SID>StripTrailingWhitespaces()
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

let g:tex_flavor="latex"
