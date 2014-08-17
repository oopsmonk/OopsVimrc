" Vim configure file
" Author: OopsMonk <oopsmonk@gmail.com>

if has("unix")
    let s:dis_ID = system("awk -F= '$1==\"ID\"{printf $2}' /etc/os-release")
endif

"--------------------------------------------------------------------------- 
" Configure Neobundle
"--------------------------------------------------------------------------- 
if has('vim_starting')
    set nocompatible               " Be iMproved

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

if s:dis_ID == 'ubuntu'
    if has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
        NeoBundle 'Shougo/neocomplete.vim'
    else
        NeoBundle 'Shougo/neocomplcache'
    endif
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'tpope/vim-fugitive'
endif

NeoBundle 'Shougo/unite.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'ervandew/supertab'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'kshenoy/vim-signature'
NeoBundle 'zeis/vim-kolor'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


"--------------------------------------------------------------------------- 
" General Settings
"--------------------------------------------------------------------------- 

set nocompatible	" not compatible with the old-fashion vi mode
set bs=2		" allow backspacing over everything in insert mode
set history=150		" keep 50 lines of command line history
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

" TAB setting{
   set expandtab        "replace <TAB> with spaces
   set softtabstop=4 
   set shiftwidth=4 

   autocmd FileType Makefile set noexpandtab
"}      							

"Auto reload vimrc
autocmd bufwritepost .vimrc,vimrc source ~/.vimrc

"Restore cursor to file position in previous editing session
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal g'\"" |
    \ endif
endif

"--------------------------------------------------------------------------- 
" Markdown Configuration 
"--------------------------------------------------------------------------- 
" Markdown extention
autocmd BufRead,BufNewFile *.md set filetype=markdown
"Auto Pandoc switch on/off
function! OnPandoc()
    let b:auto_doc
endfunction

function! OffPandoc()
    unlet b:auto_doc
endfunction

" Auto Pandoc function
function! AutoPandoc()
    "check if enable this function
    if exists("b:auto_doc")
        "check if pandoc exist
        if filereadable("/usr/bin/pandoc")
            " get current directory path and append CSS file
            let l:csspath=expand("%:p:h")."/pandoc-markdownpad-github.css"
            let l:outPut=expand("%:p:h")."/out.html"
            if filereadable(l:csspath)
                "remove old output
                if filereadable(l:outPut)
                    let l:rmOut="!rm -rf ".l:outPut." && sync"
                    silent execute l:rmOut
                endif

                " run command
                let l:runCmd="!pandoc -H ".l:csspath." -s ".expand("%:p")." -o ".l:outPut
                echo "Auto generated HTML at ".l:outPut
                silent execute l:runCmd
            endif
        endif
    endif
endfunction

"Audo gen html for markdown
let b:auto_doc="ture"
autocmd BufWritePost *.markdown,*md call AutoPandoc()

"--------------------------------------------------------------------------- 
" Color scheme  
"--------------------------------------------------------------------------- 
set t_Co=256
try
    colorscheme kolor
catch /^Vim\%((\a\+)\)\=:E185/
    "Notthing
endtry

set laststatus=2
set statusline=%4*%<\ %1*[%F]
set statusline+=%4*\ %5*[%{&encoding}, " encoding
set statusline+=%{&fileformat}]%m " file format
set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>
highlight User1 ctermfg=red
highlight User2 term=underline cterm=underline ctermfg=green
highlight User3 term=underline cterm=underline ctermfg=yellow
highlight User4 term=underline cterm=underline ctermfg=white
highlight User5 ctermfg=cyan
highlight User6 ctermfg=white

"--------------------------------------------------------------------------- 
" ENCODING SETTINGS
"--------------------------------------------------------------------------- 
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

"--------------------------------------------------------------------------- 
" Key Mapping 
"--------------------------------------------------------------------------- 
"Moving around long lines. 
map j gj
map k gk
map <Space> <PageDown>

"Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Useful mappings for managing tabs
map <F2> :tabnext<cr>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

map <leader>1 :Unite buffer<cr>
map <leader>2 :Unite file<cr>
map <F3> :TagbarToggle<cr>
map <F4> :NERDTreeToggle<cr>
if s:dis_ID == 'ubuntu'
    noremap <F9> :exe ':silent !firefox %'<cr>
endif

" Spell check
map <leader>ss :setlocal spell!<cr>
"--------------------------------------------------------------------------- 
" EasyMotion Plugin
"--------------------------------------------------------------------------- 
let g:EasyMotion_leader_key = ','
let g:EasyMotion_do_shade = 0
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

"--------------------------------------------------------------------------- 
" Syntastic (syntax checker)
"--------------------------------------------------------------------------- 
let g:syntastic_python_checkers=['pyflakes']

"--------------------------------------------------------------------------- 
" neocomplete 
"--------------------------------------------------------------------------- 
" Use neocomplete.
let g:neocomplete_enable_at_startup = 1
" Use smartcase.
let g:neocomplete_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete_min_syntax_length = 3
let g:neocomplete_lock_buffer_name_pattern = '\*ku\*'

"--------------------------------------------------------------------------- 
" neocomplcache 
"--------------------------------------------------------------------------- 
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"--------------------------------------------------------------------------- 
" vim-signature 
"--------------------------------------------------------------------------- 
"Clear marks when quit 
autocmd BufUnload * call signature#PurgeMarks() 
