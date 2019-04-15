set nocompatible
set autoindent

" - shift key (and >>) adds 4 spaces, except for LaTeX, where it adds only 2
" - softtabstop makes VIM see n spaces as a tabstop, which is useful when
" typing Backspace and Delete
set softtabstop=4
set shiftwidth=4
autocmd FileType tex setlocal shiftwidth=2
autocmd FileType tex setlocal softtabstop=2

let g:tex_flavor = "latex"

" Function and corresponding command to remove trailing whitespace
function! TrailingWhitespaceRemove()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction
command! TrailingWhitespaceRemove call TrailingWhitespaceRemove()
" In cpp code, remove trailing whitespace when saving
autocmd FileType c,cpp autocmd BufWritePre <buffer> :TrailingWhitespaceRemove

" Set space key as leader
let mapleader = " "

" TAB completion shows an advanced menu instead of cycling through options
set wildmenu

" insert spaces instead of \t when Tab is pressed
set expandtab

" fix backspace (don't know why it stopped working)
set backspace=indent,eol,start

"when typing <TAB> at bginning of line, use 'shiftwidth' rather than 'tabstop'
set smarttab

" show line and column number on status bar
"set ruler
"set rulerformat=%l,%v
" statusline replaces ruler above
set noruler
set laststatus=2
set statusline=%f%m%r%h%w\ [%Y]\ %{fugitive#statusline()}%=%l,%v\ (%p%%\ of\ %L)

set formatoptions+=l
set lbr
set nolist

" make help window open a vertical split
cnoremap help vert help

" open (close) automatically as entering (leaving) them
"set foldopen=all
"set foldclose=all
" folds less than N lines are always shown open
set foldminlines=3
" folds only until depth 2 (functions, classes, top-level comments -- possibly inside namespace)
set foldnestmax=2

" Search for tags in ancestor directories
set tags=./tags;/

" tagbar plugin (http://www.vim.org/scripts/script.php?script_id=3465)
nmap <Leader>o :TagbarToggle<CR>
let g:tagbar_autofocus = 1 " when tagbar window is toggled, focus into it
let g:tagbar_sort = 1 " sort tags (functions, variables, ..) by name
let g:tagbar_compact = 1 " remove help message and empty lines
let g:tagbar_autoclose = 1 " close tagbar window when jumping to tag with Enter
let g:tagbar_foldlevel = 0 " folds up to this level will be displayed folded initially

" tagbar for latex
" (http://stackoverflow.com/q/26145505/1268568)
let g:tagbar_type_tex = {
    \ 'ctagstype' : 'latex',
    \ 'kinds'     : [
        \ 's:sections',
        \ 'g:graphics:0:0',
        \ 'l:labels',
        \ 'r:refs:1:0',
        \ 'p:pagerefs:1:0'
    \ ],
    \ 'sort'    : 0,
    \ }

" Set syntax-based folding for source code
autocmd FileType c setlocal foldmethod=syntax
autocmd FileType cpp setlocal foldmethod=syntax

" Shows command while it's typed
set showcmd

" disable auto-commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" comment strings for vim-commentary
autocmd FileType cmake set commentstring=#\ %s
autocmd FileType cpp set commentstring=//\ %s

" make a.vim plugin (alternate between header and code) look in src and
" include folders
let g:alternateSearchPath = 'reg:|src|include|,reg:|include|src|'
let g:alternateNoDefaultAlternate = 1
nnoremap <Leader>a :A<CR>
" a.vim has insert-mode mappings for <leader>, which creates a delay when
" typing the leader key in insert mode -- edited plugin/a.vim file!

" mappings to close window and delete buffer without closing its window
nnoremap <Leader>c :close<CR>
nnoremap <leader>d :bp<bar>sp<bar>bn<bar>bd<CR>
" map :W to :w and :Q to :q
command! Q q
command! W w
command! WQ wq
command! Wq wq

"Format current line or current selection as json using python
nnoremap <Leader>aj :.!python -m json.tool<CR>
vnoremap <Leader>aJ :'<,'>!python -m json.tool<CR>

"Start scrolling when we're 8 lines away from margins
set scrolloff=5
set sidescrolloff=15
set sidescroll=1

" Relative numbering (hybrid style provided by vim-numbertoggle)
set number relativenumber
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
au FileType tex set iskeyword+=:
" In C++ code, it's better to split classes and its methods/members
au FileType cpp set iskeyword-=:

" Set gnuplot filetype for corresponding file extension
au BufNewFile,BufRead *.gp setf gnuplot

" make PDF as default compilation target of vim-latex
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='evince'
" do not move to line of first error after compiling latex file
let g:Tex_GotoError=0
" compile multiple times and run bibtex when ref's or cite's change, etc
" CAVEAT: bibtex is always run
let g:Tex_MultipleCompileFormats='pdf'
" shortcut to save and compile latex when in insert mode
autocmd Filetype tex inoremap <buffer> <C-k> <Esc> :update <CR> <Leader> ll <CR>
autocmd Filetype tex noremap <buffer> <C-k> <Esc> :update <CR> <Leader> ll <CR>

" For other filetypes, <C-k> just exits insert mode and saves
autocmd Filetype tex inoremap <buffer> <C-k> <Esc> :update <CR>
autocmd Filetype tex noremap <buffer> <C-k> <Esc> :update <CR>

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

" place all backups and swaps in a central place
let my_backup_dir = $HOME . "/.tmp/vim_backup"
if !isdirectory(my_backup_dir)
    call mkdir(my_backup_dir, "p")
endif
set backup
let &backupdir=my_backup_dir
let my_tmp_dir = $HOME . "/.tmp/vim_tmp"
if !isdirectory(my_tmp_dir)
    call mkdir(my_tmp_dir, "p")
endif
let &directory=my_tmp_dir

" always keep PWD equal to directory of current buffer
"set autochdir

" TODO removed CtrlP; now using fzf
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_extensions = ['buffertag', 'tag']
" " use CtrlP to search through buffers and buffertags
" map <C-b> :CtrlPBuffer <CR>
" " use CtrlPBufTagAll for search within all open buffers
" map <C-t> :CtrlPBufTagAll <CR>
" " use silversearch ag for faster searching, if available
" let g:ctrlp_clear_cache_on_exit = 0
" if executable('ag')
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" endif

" toggle pastemode
nnoremap <C-c> :set paste! paste?<CR>
" also in insert mode, which deisables Ctrl+C to exit insert mode
" (which is a bad idea anyway)
inoremap <Esc><C-c> :set paste! paste?<CR>

syntax on

" YouCompleteMe configuration
let g:ycm_always_populate_location_list = 1
let g:ycm_show_diagnostics_ui = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0

" ListToggle plugin
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" vim-dispatch configuration -> deprecated by plugin vimtex!
" autocmd FileType tex let b:dispatch = 'latexmk %'
" autocmd FileType tex let b:dispatch = 'latexmk main'
" nnoremap <F9> :Dispatch<CR>

" Disable overfull and underfull warnings on vimtex
" let g:vimtex_quickfix_latexlog = { 'overfull' : 0, 'underfull' : 0 }

" Do not open vimtex quickfix window if there are warnings but no errors
let g:vimtex_quickfix_open_on_warning = 0

" Use double quote for vimtex imaps rather than `, which is used to insert actual double quotes in the LaTeX output
let g:vimtex_imaps_leader = '"'

let g:matchparen_timeout = 2
let g:matchparen_insert_timeout = 2

" TODO: I tried putting these in the after-directory, but it doesn't work for
" some reason
" whitelist of local vimrc files to load without asking
let g:localvimrc_whitelist = ['/home/tsi/csauer/dotfiles/.vimrc_hyper', '/Users/csauer/dotfiles/.vimrc_hyper']
" I can't make it stop asking if file should be loaded without a sandbox, so disable it
let g:localvimrc_sandbox = 0

" write rtags log to this file
let g:rtagsLog = '~/.tmp/rtags.log'

" Interpret SGML files as XML for correct folding
autocmd FileType sgml set filetype=xml

" Fold XML elements (https://stackoverflow.com/a/46217327/1268568)
augroup XML
    autocmd!
    autocmd FileType xml let g:xml_syntax_folding=1
    autocmd FileType xml setlocal foldmethod=syntax
    autocmd FileType xml setlocal foldlevel=1
    autocmd FileType xml :syntax on
 augroup END

"-----------------------------------------
" Vundle plugin
" ----------------------------------------
set nocompatible                   " required!
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle required!
Plugin 'VundleVim/Vundle.vim'

" My Bundles here:
Plugin 'Valloric/YouCompleteMe'
Plugin 'Valloric/ListToggle'
Plugin 'sgeb/vim-diff-fold'
Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'majutsushi/tagbar'
" Plugin 'SirVer/ultisnips' -- not slow
" Plugin 'jceb/vim-orgmode'
Plugin 'lervag/vimtex'
Plugin 'embear/vim-localvimrc'
Plugin 'lyuts/vim-rtags'
Plugin 'mhinz/vim-grepper'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Plugin 'scrooloose/nerdtree'
Plugin 'elzr/vim-json'
" Plugin 'chrisbra/NrrwRgn'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/vim-peekaboo'
" Hyper-specific syntax highlighting
Plugin 'git@gitlab.tableausoftware.com:avogelsgesang/vim-hyper-test-syntax'
Plugin 'caetanosauer/vim-syntax-extra'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'tommcdo/vim-exchange'
Plugin 'junegunn/gv.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
" Plugin 'liuchengxu/vim-which-key'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" ------------------------------------------
"  Vundle plugin end
"  -----------------------------------------

 " Color scheme
set termguicolors
set background=dark
colorscheme nord
