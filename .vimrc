"https://github.com/jbbarth/dotfiles/

"-------------------------------------------------------------
" 010 - include tpope's pathogen to manage plugin/bundles/etc.
"       see: https://github.com/tpope/vim-pathogen/
"-------------------------------------------------------------
call pathogen#infect()

" See: http://linux-attitude.fr/post/Vimrc-collaboratif
" 
" Defaults options (keep it at the top of your vimrc)
set nocompatible

" Syntax highlighting
set t_Co=256
syntax on

" Automatic background color
set background&

filetype off
filetype plugin indent on

" Keep cursor position when re-openning a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" If not already done, display cursor position
set ruler

" Smart searchs : if no uppercase letter, search will be case-insensitive
set smartcase

" Never be case sensitive
set ignorecase

" Déplacer le curseur quand on écrit un (){}[] (attention il ne s'agit pas du highlight
"set showmatch

" Visual mode : Display de number of selected lines in visual mode
" Command mode : display the most recent touch/command
set showcmd

" Moves cursor as you type the search mask
" => not so good...
"set incsearch

" Let you use mouse if your terminal can do it
" set mouse=a

" Disable auto-indent ; opposite of "paste"
"set nopaste

" Display the number of changes after a command, if > 0
set report=0

" Highlights all search results
set hlsearch

" Creates backup files
set backup

" Put backup files in ~/.vim/backup
" And create directory if necessary
if filewritable(expand("~/.vim/backup")) == 2
  set backupdir=$HOME/.vim/backup
else
  if has("unix") || has("win32unix")
    call system("mkdir $HOME/.vim/backup -p")
    set backupdir=$HOME/.vim/backup
  endif
endif

" Disable wrap for loooong lines
set wrap

" Checks spell as you type (english)
"set spell


" For coders
"
" Preserve indent (necessary with next lines)
set preserveindent
" Auto indent
"set autoindent
" Indent width
set shiftwidth=2
" Indent value is a round number
set shiftround
" Width of a tabulation (\t)
set tabstop=2
" Width of a [TAB] indent (?)
set softtabstop=2
" Replace tabulations (\t) with spaces
set expandtab

" Highlight current line (in blue)
"set cursorline
"highlight CursorLine ctermbg=blue

" Show line numbers
" set number

" Use shiftwidth instead of tabstop at the beginning of the line
" and backspace deletes everything if there are only spaces
set smarttab

" +x rights if file begins with #! or contains "/bin/" in its path
function ModeChange()
  if getline(1) =~ "^#!" || getline(1) =~ "/bin/"
    silent !chmod a+x <afile>
  endif
endfunction

au BufWritePost * call ModeChange()

" Better autoindent
set noautoindent
filetype plugin indent on
filetype indent on



map <F9> :%s/\t/  /g
map <F8> :call ToggleCommentify()<CR>j
function! ToggleCommentify()
	let lineString = getline(".")
	if lineString != $									" don't comment empty lines
		let isCommented = strpart(lineString,0,3)		" getting the first 3 symbols
		let fileType = &ft								" finding out the file-type, and specifying the comment symbol
    let commentSymbolAfter = ''
		if fileType == 'ox' || fileType == 'cpp' || fileType == 'cu' || fileType == 'c' || fileType == 'php' || fileType == 'javascript'
			let commentSymbolBefore = '///'
		elseif fileType == 'vim'
			let commentSymbolBefore = '"""'
		elseif fileType == 'python'
			let commentSymbolBefore = '###'
    elseif fileType == 'xml'
      let commentSymbolBefore = '<!--'
      let commentSymbolAfter  = ' -->'
    else
      execute 'echo "WARNING: File type not detected. Using default comment token"'
      let commentSymbolBefore = '###'
    endif
		if isCommented == strpart(commentSymbolBefore,0,3)
			call UnCommentify(commentSymbolBefore, commentSymbolAfter) " if the line is already commented, uncomment
		else
			call Commentify(commentSymbolBefore, commentSymbolAfter)				 " if the line is uncommented, comment
		endif
	endif
endfunction

function! Commentify(commentSymbolBefore, commentSymbolAfter)
	set nohlsearch
	execute ':s+^+'.a:commentSymbolBefore.'+'					| " go to the beginning of the line and insert the comment symbol 
	execute ':s+$+'.a:commentSymbolAfter.'+'					| " go to the end of the line and append the comment symbol 
	set hlsearch										                    " note: the '|' is so I can put a quote directly after an execute statement
endfunction
	
function! UnCommentify(commentSymbolBefore, commentSymbolAfter)
	set nohlsearch
	execute ':s+^'.a:commentSymbolBefore.'++'					| " go to the beginning of the line and remove the comment symbol 
	execute ':s+'.a:commentSymbolAfter.'$++'					| " go to the end of the line and remove the comment symbol 
	set hlsearch	
endfunction

" Status line
" See: http://informatique-et-liberte.tuxfamily.org/2009/06/27/vim-et-son-vimrc-une-barre-detat-personnalisee/
set laststatus=2 " display the status bar (0 = hide, 1 = only if splitted)
if has("statusline")
  set statusline=\ %f%m%r\ [%{strlen(&ft)?&ft:'-'},%{strlen(&fenc)?&fenc:&enc},%{&fileformat},ts:%{&tabstop}]%=%l,%c%V\ %P
elseif has("cmdline_info")
  set ruler " Display cursor position at bottom right
endif

" Auto completion (wildmode)
" See: http://informatique-et-liberte.tuxfamily.org/2009/06/26/vim-et-son-vimrc-selectionner-plus-rapidement-commandes-et-fichiers/
set wildmode=longest,full " Le wildchar TAB complete le plus possible et un eventuel autre wildchar fera s'afficher tour a tour le propositions possibles pour la selection d'un fichier ou d'une commande
if has("wildmenu")
 set wildmenu
endif
" Ignored extensions
if has("wildignore")
 set wildignore=*.swp
endif
" Minor priority extensions
set suffixes=.aux,.bak,.bbl,.blg,.gif,.gz,.idx,.ilg,.info,.jpg,.lof,.log,;lot,.o,.obj,.pdf,.png,.swp,.tar,.toc,~

" ruby folding
"autocmd Filetype ruby source ~/.vim/scripts/ruby-macros.vim

" railscasts-like colors
" see: http://www.vim.org/scripts/script.php?script_id=2175
"set term=gnome-256color
"colorscheme railscasts

" toggle between paste/nopaste modes
set pastetoggle=<F5>

" display lines before/after cursors
set scrolloff=3

" default encoding
set encoding=utf-8
set fileencoding=utf-8
