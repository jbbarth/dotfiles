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

" Allow unsaved background buffers and remember marks/undo for them
set hidden

" Larger vim default buffer
set viminfo='20,<1000

" Syntax highlighting
set t_Co=256
syntax on

" Go syntaxhl
au BufRead,BufNewFile *.go set filetype=go

" JSX syntaxhl
au BufRead,BufNewFile *.jsx set filetype=javascript

" Proto syntaxhl
augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

" Exuberant ctags
set tags=./tags,tags,.git/tags,/;

" Automatic background color
set background=light
" And set a colorscheme
let g:solarized_termcolors=256
"let g:solarized_termtrans=1
"""""""""""""""""""""""""""""" COMMENTED OUT bc/ grey is too dark: colorscheme solarized
colorscheme solarized
"call togglebg#map("<F5>")

" Manually force transparent background because tmux forces it to a dark one
" and I couldn't find out why
if &term =~ 'screen-256color'
  highlight Normal ctermbg=None
  highlight rubyDefine ctermbg=None
endif

" Change mapleader default char
let mapleader=";"

filetype off
filetype plugin indent on

" Keep cursor position when re-openning a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g`\"" | endif
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
" Skip backup strategy for crontab files, else they break on MacOSX
" http://drawohara.com/post/6344279/crontab-temp-file-must-be-edited-in-place
au FileType crontab set nobackup nowritebackup

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
"set number

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

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
"
" taken from: https://github.com/keelerm84/spf13-vim/commit/1eb005b
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Better autoindent
set noautoindent
filetype plugin indent on
filetype indent on



map <F9> :%s/\t/  /g
map <F8> :call ToggleCommentify()<CR>j
map <c-c> :call ToggleCommentify()<CR>j
function! ToggleCommentify()
	let lineString = getline(".")
	" if lineString !~ '$'									" don't comment empty lines
	let isCommented = strpart(lineString,0,3)		" getting the first 3 symbols
	let fileType = &ft								" finding out the file-type, and specifying the comment symbol
  let commentSymbolAfter = ''
	if fileType == 'ox' || fileType == 'cpp' || fileType == 'cu' || fileType == 'c' || fileType == 'php' || fileType == 'javascript' || fileType == 'go' || fileType == 'scss'
		let commentSymbolBefore = '///'
	elseif fileType == 'vim'
		let commentSymbolBefore = '"""'
	elseif fileType == 'python' || fileType == 'ruby'
		let commentSymbolBefore = '###'
  elseif fileType == 'xml' || fileType == 'html' || fileType == 'eruby'
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
endfunction

function! Commentify(commentSymbolBefore, commentSymbolAfter)
  execute 'echo "commenting"'
	set nohlsearch
	execute ':s+^+'.a:commentSymbolBefore.'+'					| " go to the beginning of the line and insert the comment symbol 
	execute ':s+$+'.a:commentSymbolAfter.'+'					| " go to the end of the line and append the comment symbol 
	set hlsearch										                    " note: the '|' is so I can put a quote directly after an execute statement
endfunction
	
function! UnCommentify(commentSymbolBefore, commentSymbolAfter)
  execute 'echo "uncommenting"'
	set nohlsearch
	execute ':s+^'.a:commentSymbolBefore.'++'					| " go to the beginning of the line and remove the comment symbol 
	execute ':s+'.a:commentSymbolAfter.'$++'					| " go to the end of the line and remove the comment symbol 
	set hlsearch	
endfunction

" Specific mappings
" hashrocket with Ctrl+l in insert mode
imap <c-l> <space>=><space>

" Map Ctrl+Q to CtrlP plugin
nmap <leader>n :CtrlP<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
" Taken from garyberhardt's vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Clear the search buffer when hitting return
" Taken from garyberhardt's vimrc
:nnoremap <CR> :nohlsearch<cr>

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

" go tabs insead of spaces
autocmd FileType go setlocal noexpandtab

" python 4 spaces indents, instead of 2
autocmd FileType python set shiftwidth=4

" toggle between paste/nopaste modes
set pastetoggle=<F5>

" display lines before/after cursors
set scrolloff=3

" default encoding
set encoding=utf-8
set fileencoding=utf-8

""" THE NEXT SECTIONS ARE BUGGY, THEY CLASH WITH RECENT VIMS (OSX SIERRA)
""" "TODO: refactor the next 3 sections using matchadd()/matchdelete()
""" " highlight trailing white spaces in red
""" highlight ExtraWhitespace ctermbg=blue guibg=red
""" 2match ExtraWhitespace /\s\+$/
""" autocmd BufWinEnter * 2match ExtraWhitespace /\s\+$/
""" autocmd InsertEnter * call clearmatches()
""" autocmd InsertLeave * 2match ExtraWhitespace /\s\+$/
"""
""" " highlight non-breaking spaces
""" highlight NbSp ctermbg=red guibg=red
""" 3match NbSp /\%xa0/
""" autocmd BufWinEnter * 3match NbSp /\%xa0/
""" autocmd InsertEnter * 3match NbSp /\%xa0/
""" autocmd InsertLeave * 3match NbSp /\%xa0/

" Adapted from: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
highlight BadWhitespace ctermbg=red guibg=red
augroup WhitespaceMatch
  " Remove ALL autocommands for the WhitespaceMatch group.
  autocmd!
  autocmd BufWinEnter * let w:whitespace_match_number = matchadd('ExtraWhitespace', '\s\+$')
  autocmd BufWinEnter * let w:bad_whitespace_match_number = matchadd('BadWhitespace', '\%xa0')
  autocmd InsertEnter * call s:ToggleWhitespaceMatch('i')
  autocmd InsertLeave * call s:ToggleWhitespaceMatch('n')
augroup END
function! s:ToggleWhitespaceMatch(mode)
  let pattern = (a:mode == 'i') ? '\s\+\%#\@<!$' : '\s\+$'
  if exists('w:whitespace_match_number')
    call matchdelete(w:whitespace_match_number)
    call matchadd('ExtraWhitespace', pattern, 10, w:whitespace_match_number)
  else
    " Something went wrong, try to be graceful.
    let w:whitespace_match_number =  matchadd('ExtraWhitespace', pattern)
  endif
endfunction
