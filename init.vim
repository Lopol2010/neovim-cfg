"set shell=bash
if exists('g:vscode')
else
	let dotvim = split(&rtp, ',')[0]
	let plugvim = dotvim . '/autoload/' . 'plug.vim'
	if empty(glob(plugvim))
	execute '!curl -fLo'.plugvim.' --create-dirs 
			\ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

	call plug#begin(dotvim . '/plugged')
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	"Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/rpc' }
	Plug 'rafi/awesome-vim-colorschemes'
	Plug 'junegunn/fzf.vim'
	Plug 'Disinterpreter/vim-pawn'
	Plug 'tpope/vim-commentary'
	call plug#end()

	exec 'source ' . dotvim . '/plug-config/coc.vim'

	:imap jk <Esc>
	:tno jk <C-\><C-n>
	" To use ALT+{h,j,k,l} to navigate windows from any mode:
	:tnoremap <A-h> <C-\><C-N><C-w>h
	:tnoremap <A-j> <C-\><C-N><C-w>j
	:tnoremap <A-k> <C-\><C-N><C-w>k
	:tnoremap <A-l> <C-\><C-N><C-w>l
	:inoremap <A-h> <C-\><C-N><C-w>h
	:inoremap <A-j> <C-\><C-N><C-w>j
	:inoremap <A-k> <C-\><C-N><C-w>k
	:inoremap <A-l> <C-\><C-N><C-w>l
	:nnoremap <A-h> <C-w>h
	:nnoremap <A-j> <C-w>j
	:nnoremap <A-k> <C-w>k
	:nnoremap <A-l> <C-w>l

	set nocompatible
	syntax on
	filetype plugin indent on
	set autoindent

	" PAWN
	"autocmd BufRead,BufNewFile *.sma setfiletype c
	autocmd BufRead,BufNewFile *.sma setfiletype pawn
	autocmd FileType pawn compiler pawn
	autocmd FileType pawn set commentstring=//%s
	let mapleader=","

	function! MakePawn()
		let sma=expand("%")
		silent make | copen
		silent exec "!./mtp.sh ".sma
		redraw!
	endfunction
	" PAWN END

	map <Leader>pc :exec MakePawn()<CR>

	set tabstop=2 shiftwidth=2 noexpandtab smarttab
	set scrolloff=8

	set incsearch
	set number relativenumber

	set mouse=a

	colo alduin
	"colo gruvbox

	" enable Normal mode keys in ru layout
	set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

	" make completion list look not ugly

	if has("nvim")
		autocmd UIEnter * let GuiPopupmenu=0
	endif
endif
