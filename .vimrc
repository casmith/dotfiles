syntax on " Syntax highlighting
set showmatch " Shows matching brackets
set ruler " Always shows location in file (line#)
set smarttab " Autotabs for certain code

:let mapleader = ","

set expandtab " On pressing tab, insert 2 spaces
set tabstop=2 " show existing tab with 2 spaces width
set softtabstop=2
set shiftwidth=2 " when indenting with '>', use 2 spaces width

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

:let g:notes_directories = ['~/Nextcloud/vim-notes']
:let g:vimwiki_list = [{'path': '~/Nextcloud/wiki', 'syntax': 'markdown', 'ext': '.md'}]

call plug#begin()

Plug 'yegappan/mru'
Plug 'felixfbecker/php-language-server', {'do': 'composer install && composer run-script parse-stubs'}

Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'vimwiki/vimwiki'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()
