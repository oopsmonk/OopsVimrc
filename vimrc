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

if s:dis_ID == 'ubuntu' || s:dis_ID == 'raspbian'
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
NeoBundle 'bling/vim-airline'
NeoBundle 'parkr/vim-jekyll'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'mbbill/undotree'
NeoBundle 'xolox/vim-misc'
"NeoBundle 'xolox/vim-notes'
NeoBundle 'vimwiki/vimwiki'

if has('clientserver')
    NeoBundle 'lervag/vimtex'
endif


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
"autocmd bufwritepost .vimrc,vimrc source ~/.vimrc

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
"Pandoc switch
function! TogglePandoc()
    if exists("b:auto_doc")
        unlet b:auto_doc
        echo "Disable Pandoc"
    else
        let b:auto_doc="true"
        echo "Enable Pandoc"
    endif
endfunction

" Markdown to HTML convertion
function! MD2HTML()
    "check if enable this function
    if exists("b:auto_doc")
        "check if pandoc exist
        if filereadable("/usr/bin/pandoc")
            " CSS file location
            let l:csspath=fnamemodify(expand("$MYVIMRC"), ":p:h")."/.vim/pandoc-markdownpad-github.css"
            let l:outPut=expand("%:p:h")."/out.html"
            if filereadable(l:csspath)
                "remove old output
                if filereadable(l:outPut)
                    let l:rmOut="!rm -rf ".l:outPut." && sync"
                    silent execute l:rmOut
                endif

                " run command
                let l:runCmd="!pandoc -H ".l:csspath." -s ".expand("%:p")." -o ".l:outPut
                echo "HTML is generated at path: ".l:outPut
                silent execute l:runCmd
            endif
        endif
    endif
endfunction

"Auto convert a markdown file to html.
" call TogglePandoc() to enable/disable
autocmd BufWritePost *.markdown,*md call MD2HTML()

"--------------------------------------------------------------------------- 
" Color scheme  
"--------------------------------------------------------------------------- 
set t_Co=256
try
    colorscheme kolor
catch /^Vim\%((\a\+)\)\=:E185/
    "Notthing
endtry
" Background transparency 
hi Normal ctermbg=none

set cursorline
"set laststatus=2
"set statusline=%4*%<\ %1*[%F]
"set statusline+=%4*\ %5*[%{&encoding}, " encoding
"set statusline+=%{&fileformat}]%m " file format
"set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>
"highlight User1 ctermfg=red
"highlight User2 term=underline cterm=underline ctermfg=green
"highlight User3 term=underline cterm=underline ctermfg=yellow
"highlight User4 term=underline cterm=underline ctermfg=white
"highlight User5 ctermfg=cyan
"highlight User6 ctermfg=white

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
let mapleader = ","
"Moving around long lines. 
map j gj
map k gk
map <c-u> <PageUp>
map <c-d> <PageDown>
map <F2> :echo expand('%:p')<cr>

"Disable highlight when <leader><cr> is pressed
"map <silent> <leader><cr> :noh<cr>

" Useful mappings for managing tabs
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
map <F4> :TagbarToggle<cr>
map <F3> :NERDTreeToggle<cr>
map <F5> :UndotreeToggle<cr>
if s:dis_ID == 'ubuntu'
    noremap <F9> :exe ':silent !firefox %' <cr> :redraw! <cr>
endif

" Spell check
map <leader>ss :setlocal spell!<cr>
" timestamp 
inoremap <F5> <C-R>=strftime("@%Y-%m-%d %H:%M")<CR>

"--------------------------------------------------------------------------- 
" EasyMotion Plugin
"--------------------------------------------------------------------------- 
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion


"--------------------------------------------------------------------------- 
" Syntastic (syntax checker)
"--------------------------------------------------------------------------- 
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_check_on_open = 1
let g:EclimFileTypeValidate = 0
let g:syntastic_check_on_wq = 0

"--------------------------------------------------------------------------- 
" neocomplete 
"--------------------------------------------------------------------------- 
if has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif 

"--------------------------------------------------------------------------- 
" neocomplcache 
"--------------------------------------------------------------------------- 
if !has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" force use neocomplete 
let g:neocomplcache_force_overwrite_completefunc = 1 

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
"let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif 

"--------------------------------------------------------------------------- 
" vim-signature 
"--------------------------------------------------------------------------- 
"Clear marks when quit 
"autocmd BufUnload * call signature#PurgeMarks() 
autocmd BufUnload * call signature#mark#Purge('all')

"--------------------------------------------------------------------------- 
" Nerdtree 
"--------------------------------------------------------------------------- 
let NERDTreeIgnore = ['\.pyc$','\.o$','\.so$','\.a$']

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
" vim-jekyll 
"--------------------------------------------------------------------------- 
let g:jekyll_post_dirs = ['_posts']
let g:jekyll_post_extension = '.md'
let g:jekyll_post_filetype = 'markdown'
let g:jekyll_post_template = [
\ '---',
\ 'layout: single',
\ 'title: "JEKYLL_TITLE"',
\ 'modified: ',
\ 'categories: TechNotes or Vida',
\ 'comments: true',
\ 'excerpt:',
\ 'tags: [滴水穿石]',
\ 'image:',
\ '  feature:',
\ 'date: "JEKYLL_DATE"',
\ '---',
\ '',
\ '以前球隊在回防時, 教練總會說"快跑! 別回頭, 到定點再休息".  ',
\ '關於人生, 喘息點在哪兒? 我想就在滴水穿石之間!  ',
\ '',
\ '# Week? (dd/MM)  ',
\ '## 網路文章  ',
\ '## 網路資源  ',
\ '## 讀書心得  ',
\ '## 論文學習  ',
\ '']

"--------------------------------------------------------------------------- 
" undotree 
"--------------------------------------------------------------------------- 
if has("persistent_undo")
    set undodir='~/.undodir/'
    set undofile
endif

"--------------------------------------------------------------------------- 
" vim-notes 
"--------------------------------------------------------------------------- 
"let g:notes_directories = ['~/.VimNotes']
"let g:notes_conceal_url = 0
"let g:notes_suffix = '.txt'

"--------------------------------------------------------------------------- 
" vimwiki  
"--------------------------------------------------------------------------- 
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.mdwiki'}]

" Arduino project file
autocmd BufRead,BufNewFile *.ino set filetype=c
