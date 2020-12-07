" Vim configure file
" Author: OopsMonk <oopsmonk@gmail.com>

"---------------------------------------------------------------------------
" General Settings
"---------------------------------------------------------------------------

set nocompatible	" not compatible with the old-fashion vi mode
set bs=2		" allow backspacing over everything in insert mode
set history=1000	" keep 1000 lines of command line history
set ruler		" show the cursor position all the time
set autoread		" auto read when file is changed from outside

filetype off          " necessary to make ftdetect work on Linux
syntax on
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

syntax on		" syntax highlight
set hlsearch		" search highlighting

set clipboard=unnamed	" yank to the system register (*) by default
set showmatch		" Cursor shows matching ) and }
"set showmode		" Show current mode
set wildchar=<TAB>	" start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set autoindent		" auto indentation
"set incsearch		" incremental search
set nobackup		" no *~ backup files
set copyindent		" copy the previous indentation on autoindenting
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to context

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" TAB setting
set expandtab        "replace <TAB> with spaces
set softtabstop=2
set shiftwidth=2
autocmd FileType Makefile set noexpandtab

"Auto reload vimrc
autocmd bufwritepost .vimrc,vimrc source ~/.vimrc

"Restore cursor to file position in previous editing session
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal g'\"" |
    \ endif
endif

" tmux color issue
" https://github.com/tmux/tmux/issues/699#issuecomment-361469310
set background=dark
set t_Co=256

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/usr/bin/env\ bash
endif

" Arduino project file
autocmd BufRead,BufNewFile *.ino set filetype=c

"---------------------------------------------------------------------------
" ENCODING SETTINGS
"---------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

"---------------------------------------------------------------------------
" vim-plug
"---------------------------------------------------------------------------
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'preservim/nerdcommenter'
Plug 'bling/vim-airline'
Plug 'vim-syntastic/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'ycm-core/YouCompleteMe'
Plug 'joshdick/onedark.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"---------------------------------------------------------------------------
" Key Mapping
"---------------------------------------------------------------------------

" Spell check
map <leader>ss :setlocal spell!<cr>

"---------------------------------------------------------------------------
" color scheme
"---------------------------------------------------------------------------
colorscheme onedark
let g:airline_theme='onedark'

"---------------------------------------------------------------------------
" Nerdtree
"---------------------------------------------------------------------------
let NERDTreeIgnore = ['\.pyc$','\.o$','\.so$','\.a$']
map <F3> :NERDTreeToggle<cr>

"---------------------------------------------------------------------------
" Airline
"---------------------------------------------------------------------------
set laststatus=2
"let g:airline_detect_whitespace=0 " remove the trailing
let g:airline#extensions#whitespace#enabled = 0
"if !exists('g:airline_symbols')
    "let g:airline_symbols = {}
"endif
"let g:airline_left_sep = '»'
"let g:airline_right_sep = '«'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '& '
"let g:airline_symbols.paste = 'ρ'

"tabline configure
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
"let g:airline#extensions#tabline#left_sep = '>'
"let g:airline#extensions#tabline#left_alt_sep = ''
"let g:airline#extensions#tabline#right_sep = ''
"let g:airline#extensions#tabline#right_alt_sep = ''

"---------------------------------------------------------------------------
" Syntastic (syntax checker)
"---------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"---------------------------------------------------------------------------
" vim-gitgutter
"---------------------------------------------------------------------------
set updatetime=1000
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)

"---------------------------------------------------------------------------
" tagbar
"---------------------------------------------------------------------------
map <F4> :TagbarToggle<cr>
