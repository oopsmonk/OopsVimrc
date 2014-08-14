" Vim configure file
" Author: OopsMonk <oopsmonk@gmail.com>

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
NeoBundle 'Shougo/unite.vim'
if has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
    NeoBundle 'Shougo/neocomplete.vim'
else
    NeoBundle 'Shougo/neocomplcache'
endif
NeoBundle 'mileszs/ack.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Lokaltog/vim-easymotion'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" General Settings

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


" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc


syntax on		" syntax highlight
set hlsearch		" search highlighting

"if has("gui_running")	" GUI color and font settings
"  set guifont=Osaka-Mono:h20
"  set background=dark 
"  set t_Co=256          " 256 color mode
"  set cursorline        " highlight current line
"  colors moria
"  highlight CursorLine          guibg=#003853 ctermbg=24  gui=none cterm=none
"else
"" terminal color settings
"  "colors vgod
"endif

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

   au FileType Makefile set noexpandtab
"}      							


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


"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


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
" ENCODING SETTINGS
"--------------------------------------------------------------------------- 
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

"--------------------------------------------------------------------------- 
" Key Mapping 
"--------------------------------------------------------------------------- 
map <Space> <PageDown>
