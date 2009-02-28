" Plein de défauts bien pratiques (à garder en début de fichier)
set nocompatible

" Coloration syntaxique, indispensable pour ne pas se perdre dans les longs fichiers
syntax on

" Le complément du précédent, devine tout seul la couleur du fond (clair sur foncé ou le contraire)
set background&

"Détection du type de fichier pour l'indentation
if has("autocmd")
  filetype indent on
endif

" Récupération de la position du curseur entre 2 ouvertures de fichiers
" Parfois ce n'est pas ce qu'on veut ...
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" SI c'est pas déjà fait, affiche la position du curseur
set ruler

" Recherche en minuscule -> indépendante de la casse, une majuscule -> stricte
set smartcase

" Ne jamais respecter la casse (attention totalement indépendant du précédent mais de priorité plus faible)
set ignorecase

" Déplacer le curseur quand on écrit un (){}[] (attention il ne s'agit pas du highlight
"set showmatch

" Affiche le nombre de lignes sélectionnées en mode visuel ou la touche/commande qu'on vient de taper en mode commande
set showcmd

" Déplace le curseur au fur et a mesure qu'on tape une recherche, pas toujours pratique, j'ai abandonné
"set incsearch

" Utilise la souris pour les terminaux qui le peuvent (tous ?)
" pratique si on est habitué à coller sous la souris et pas sous le curseur, attention fonctionnement inhabituel
"set mouse=a

" A utiliser en live, paste désactive l'indentation automatique (entre autre) et nopaste le contraire
set nopaste

" Indiquer le nombre de modification lorsqu'il y en a plus de 0 suite à une commande
set report=0

" Met en évidence TOUS les résultats d'une recherche, A consommer avec modération
set hlsearch

" Crée des fichiers ~ un peu partout ...
set backup

" La ruse de sioux pour ne pas qu'ils soient partout (à vous de faire le mkdir)
" En général n'édite pas 2 fichiers de même noms fréquemment dans des répertoires différents, sinon évitez
" -> voir by eric plus bas

" Laisse les lignes déborder de l'écran si besoin
"set nowrap

" En live pour quand vous écrivez anglais (le fr est à trouver dans les méandres du net)
"set spell


" Spécial développeurs
"
" Indispensable pour ne pas tout casser avec ce qui va suivre
set preserveindent
" indentation automatique
"set autoindent
" Largeur de l'autoindentation
set shiftwidth=2
" Arrondit la valeur de l'indentation
set shiftround
" Largeur du caractère tab
set tabstop=2
" Largeur de l'indentation de la touche tab
set softtabstop=2
" Remplace les tab par des expaces
set expandtab

" by acieroid
" -----------
" Pour highlighter la ligne courante (pour mieux se repérer) en bleu :
"set cursorline
"highlight CursorLine ctermbg=blue

" Pour activer les numéros de lignes dans la marge :
"set number

" by eric
" -----------
" Utilise shiftwidth à la place de tabstop en début de ligne (et backspace supprime d'un coup si ce sont des espaces)
set smarttab

" sauvegarder les fichier ~ dans ~/.vim/backup avec crréation du répertoire si celui-ci n'existe pas
if filewritable(expand("~/.vim/backup")) == 2
  set backupdir=$HOME/.vim/backup
else
  if has("unix") || has("win32unix")
    call system("mkdir $HOME/.vim/backup -p")
    set backupdir=$HOME/.vim/backup
  endif
endif

" donner des droits d'exécution si le fichier commence par #! et contient /bin/ dans son chemin
function ModeChange()
  if getline(1) =~ "^#!"
    if getline(1) =~ "/bin/"
      silent !chmod a+x <afile>
    endif
  endif
endfunction

au BufWritePost * call ModeChange()

" by anonyme
" -----------
" autoindent n'est spécifique à aucun langage et fonctionne en général moins bien
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
		if fileType == 'ox' || fileType == 'cpp' || fileType == 'cu' || fileType == 'c' || fileType == 'php'
			let commentSymbol = '///'
		elseif fileType == 'vim'
			let commentSymbol = '"""'
		elseif fileType == 'python'
			let commentSymbol = '###'
                else
                    execute 'echo "WARNING: File type not detected. Using default comment token"'
                        let commentSymbol = '###'
                endif
"""		else
"""			execute 'echo "ToggleCommentify has not (yet) been implemented for this file-type"'
"""			let commentSymbol = ''
"""		endif
		if isCommented == commentSymbol					
			call UnCommentify(commentSymbol)			" if the line is already commented, uncomment
		else
			call Commentify(commentSymbol)				" if the line is uncommented, comment
		endif
	endif
endfunction

function! Commentify(commentSymbol)	
	set nohlsearch	
	execute ':s+^+'.a:commentSymbol.'+'					| " go to the beginning of the line and insert the comment symbol 
	set hlsearch										  " note: the '|' is so I can put a quote directly after an execute statement
endfunction
	
function! UnCommentify(commentSymbol)	
	set nohlsearch	
	execute ':s+'.a:commentSymbol.'++'					| " remove the first comment symbol found on a line
	set hlsearch	
endfunction

