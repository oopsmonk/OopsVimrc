OopsVimrc
=========

###Request:  

Install ACK2 for ack.vim  
`curl http://beyondgrep.com/ack-2.12-single-file > ~/bin/ack && chmod 0755 !#:3`

Install necessary packages  
`sudo apt-get install curl pyflakes exuberant-ctags`  


* [*curl*](http://curl.haxx.se/)  
* [*pyflakes*](https://pypi.python.org/pypi/pyflakes): Python syntax checking.    
* [Ack – for 工程師用的 grep](http://brooky.cc/2012/09/28/ack-for-%E5%B7%A5%E7%A8%8B%E5%B8%AB%E7%94%A8%E7%9A%84-grep/)   
* [*exuberant-ctags*](http://ctags.sourceforge.net/): support Tagbar.  

###Install:  

`curl https://raw.githubusercontent.com/oopsmonk/OopsVimrc/master/auto-install.sh | sh`


###Key Mappings
*`<leader><cr>`* Clear search highlighting  
*`<leader>ss`*  Spell check   
*`<F2>`*        tabnext  
*`<leader>tn`*  tabnew  
*`<leader>to`*  tabonly   
*`<leader>tc`*  tabclose  
*`<leader>tm`*  tabmove  
*`<leader>te`*  New tab with the current buffer's path  
*`<leader>cd`*  CD to current buffer's path  
*`<leader>1`*   Unite buffer  
*`<leader>2`*   Unite file  
*`<F3>`*        TagbarToggle  
*`<F4>`*        NERDTreeToggle  
*`<F9>`*        Open file in Firefox (Preview Markdown or HTML files)  

###Plugins

* [Shougo/unite.vim](https://github.com/Shougo/unite.vim)
* [Shougo/neocomplcache](https://github.com/Shougo/neocomplcache)
* [mileszs/ack.vim](https://github.com/mileszs/ack.vim)
* [scrooloose/nerdtree](https://github.com/scrooloose/nerdtree)
* [majutsushi/tagbar](https://github.com/majutsushi/tagbar)
* [Lokaltog/vim-easymotion](https://github.com/Lokaltog/vim-easymotion)
* [ervandew/supertab](https://github.com/ervandew/supertab)
* [scrooloose/nerdcommenter](https://github.com/scrooloose/nerdcommenter)
* [tpope/vim-surround](https://github.com/tpope/vim-surround)
* [Townk/vim-autoclose](https://github.com/Townk/vim-autoclose)
* [kshenoy/vim-signature](https://github.com/kshenoy/vim-signature)

###Color Schemes  

* [zeis/vim-kolor](https://github.com/zeis/vim-kolor)
