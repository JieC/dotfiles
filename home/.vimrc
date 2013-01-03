set nocompatible
set shortmess=atI " Quick start

" ========== NeoBundle Init ==========

" Check if NeoBundle installed
let bundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')
if !filereadable(bundle_readme)
    echo "Installing NeoBundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
endif

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/vimproc', {'build' : {'unix': 'make -f make_unix.mak'}}
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Lokaltog/vim-powerline'

filetype plugin indent on " Required!

" Installation check.
if neobundle#exists_not_installed_bundles()
    echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
    echomsg 'Please execute ":NeoBundleInstall" command.'
    echomsg ''
endif

" ============ Encodeing ============
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

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
silent !mkdir ~/.vim/.undo > /dev/null 2>&1
set undodir=~/.vim/.undo
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
set foldenable      " Auto fold code
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
        set guifont = Envy_Code_R:h11
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
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd BufRead *.py nmap <F5> :!python "%"<CR>

" Javascript
autocmd FileType javascript shiftwidth=2 tabstop=2
