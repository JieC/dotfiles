set nocompatible
set shortmess=atI " Quick start

" ========== Path Settings ==========
if has('win32')
    let $VIMFILES=$VIM.'/vimfiles'
    "let $HOME=$VIMFILES
else
    let $VIMFILES=$HOME.'/.vim'
endif

" ========== NeoBundle Init ==========

" Check if NeoBundle installed
let $BUNDLE=expand($VIMFILES.'/bundle')
let $NEOBUNDLE=expand($BUNDLE.'/neobundle.vim')
if !isdirectory($NEOBUNDLE)
    echo 'Installing NeoBundle..'
    echo ''
    exe 'silent !mkdir -p' '"'.$BUNDLE.'"'
    exe 'silent !git clone https://github.com/Shougo/neobundle.vim' '"'.$NEOBUNDLE.'"'
endif

if has('vim_starting')
    set runtimepath+=$NEOBUNDLE
endif

call neobundle#rc($BUNDLE)

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'https://github.com/Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'https://github.com/Shougo/vimproc', {'build' : {'unix': 'make -f make_unix.mak'}}
NeoBundle 'https://github.com/tpope/vim-fugitive'
"NeoBundle 'https://github.com/Lokaltog/vim-easymotion'
NeoBundle 'https://github.com/altercation/vim-colors-solarized'
NeoBundle 'https://github.com/Lokaltog/vim-powerline'
NeoBundle 'https://github.com/Shougo/vimshell'
NeoBundle 'https://github.com/Shougo/unite.vim'
NeoBundle 'https://github.com/Shougo/vimfiler'
NeoBundle 'https://github.com/Shougo/neocomplcache'
NeoBundle 'https://github.com/Shougo/neosnippet'
NeoBundle 'https://github.com/scrooloose/syntastic'
NeoBundle 'https://github.com/sjl/gundo.vim'
NeoBundle 'https://github.com/scrooloose/nerdcommenter'
"NeoBundle 'https://github.com/nathanaelkane/vim-indent-guides'
NeoBundle 'https://github.com/vim-scripts/YankRing.vim'
NeoBundle 'https://github.com/Raimondi/delimitMate'
NeoBundle 'https://github.com/tpope/vim-surround'

filetype plugin indent on     " Required!

" Installation check.
if neobundle#exists_not_installed_bundles()
    echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
    echomsg 'Please execute ":NeoBundleInstall" command.'
endif

" ============ Encodeing ============
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileformats=unix,dos

" ========== General Config ==========
syntax on           " Syntax highlighting
set mouse=a         " Enable mouse
set hidden          " Allow buffer switching without saving
set history=1000    " Enable Longer cmd history
set showmode        " Display the current mode
set number          " SHow line numbers
set showmatch       " Show matching brackets/parenthesis
set linespace=0     " No extra spaces between rows
set nowrap          " No wrap long lines
set linebreak       " Wrap lines at linebreaks
set winminheight=0  " Windows can be 0 line high
set laststatus=2    " Always show the statusline

" ========== Search ================
set incsearch       " Find as you type search
set hlsearch        " Highlight search terms
set ignorecase      " Case insensitive search
set smartcase       " Case sensitive when uppercase present

" ============ No Backup =========
set noswapfile
set nobackup

" =========== Persistent Undo =======
let $UNDODIR=$VIMFILES.'/.undo'
if !isdirectory($UNDODIR)
    exe 'silent !mkdir' '"'.$UNDODIR.'"'
endif
set undodir=$UNDODIR
set undofile

" ============== Indentation ===========
set autoindent
set smartindent
set smarttab
set shiftwidth=4    " Use indents of 4 spaces
set expandtab       " Tabs are spaces, not tabs
set tabstop=4       " An indentation every four columns
set softtabstop=4   " Let backspace delete indent

" ======= Code Folding ======
"set foldenable      " Auto fold code
set foldmethod=indent
set foldlevel=999

" ========= Completion ========
set wildmenu        " Show list instead of just completing
set wildignorecase
set wildmode=list:longest,full
set wildignore=*.pyc

" ==============Navigation ==========
set backspace=indent,eol,start  " Backspace for dummies
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap to
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor

" ================ UI =================
set background=dark
colorscheme solarized
set cursorline      " Highlight current line

if has('gui_running')
    if has('win32')
        "set guifont = Envy_Code_R:h11
        set guifont=Consolas:h11
    else
        set guifont=Envy\ Code\ R\ 11
    endif
    set guioptions+=b
else
    set t_Co=256
    set title       " Set terminal title
endif

" ================ Shortcut ==============

" Change map leader to ","
let mapleader = ","

" Quick edit and source vimrc
nmap <leader>v :tabedit $MYVIMRC<CR>
if has('autocmd')
    autocmd! bufwritepost .vimrc source $MYVIMRC
endif

set pastetoggle=<F12>   " Toggle paste mode

" Invoke sudo
cmap w!! %!sudo tee > /dev/null %

" Show whitespace, toggled with <leader>s
set listchars=tab:>-,trail:·,eol:¶
nmap <silent> <leader>s :set nolist!<CR>

" ================ Key Mapping ===============
imap jk <esc>

" =============== Speecific Language Settings ==========
" python
autocmd BufRead *.py nmap <F5> :!python "%"<CR>
"let $PYTHONHOME='path\to\python'
"let $PYTHONPATH='path\to\python\Lib'

" Javascript
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4

" ================ Plugins =============
" NeoComplCache
"let g:neobundle#types#git#default_protocol = 'https'
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }
" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Enable omni completion. Not required if they are already set elsewhere in .vimrc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" Neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
