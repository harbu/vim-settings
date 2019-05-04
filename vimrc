set nocompatible                " Vim settings over old Vi, must be first!
set backspace=indent,eol,start  " allow backspacing everything in insert mode

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else
  set autoindent		" always set autoindenting on
endif


" Pathogen initialization i.e. load bundle
call pathogen#infect()

" -----------------------------------------------------------------------------
" VISUAL SETTINGS
" -----------------------------------------------------------------------------

" Enable 256 colors when not using a GUI.
if !has("gui_running")
    set t_Co=256
endif

colorscheme wombat256       " Default color scheme
set number                  " Line numbering
set cursorline              " Highlight current line

" Visual color column at +1 of text width
if exists("&colorcolumn")
  set colorcolumn=+1
  highlight ColorColumn ctermbg=8 guibg=gray35
endif

" Style special list characters (i.e. tab, EOL)
hi NonText ctermfg=darkgray guifg=darkgray
hi SpecialKey ctermfg=darkgray guifg=darkgray ctermbg=NONE guibg=NONE

" Underline spelling mistakes
if version >= 700
  hi SpellBad   guisp=red    gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
  hi SpellCap   guisp=yellow gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
  hi SpellRare  guisp=blue   gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
  hi SpellLocal guisp=orange gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
endif


" -----------------------------------------------------------------------------
" COMMANDS / SHORTCUTS
" -----------------------------------------------------------------------------

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Allow SHIFT+h and SHIFT+l to cycle tabs
map <S-h> gT
map <S-l> gt

" F2 shortcut to open nerdtree file browser
map <F2> :NERDTreeToggle<CR>

" Shortcut to strip all trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Handier command mode shortcut
imap å <ESC>
vmap å <ESC>
smap å <ESC>

" Shortcut to rapidly toggle `set list`
set listchars=tab:▸\ ,eol:¬
nmap <leader>l :set list!<CR>

" Allow :W to write to file (capital w)
command! W write

" Easy split navigation (http://vimbits.com/bits/10)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle spell-checking with function key
map <F3> :setlocal spell! spelllang=en_us<CR>

" Toggle extraneous whitespace highlighting
map <F4> :ToggleBadWhitespace<CR>

" Clear CtrlP cache
nmap <leader>p :CtrlPClearAllCaches<CR>

" -----------------------------------------------------------------------------
" PLUGIN SETTINGS
" -----------------------------------------------------------------------------
" Ezbar: Enable
let g:ezbar_enable = 1
set laststatus=2

" NERDTree and CtrlP: ignore certain file types
set wildignore+=*~,.git,*.pyc,*.class
let NERDTreeIgnore = ['\.pyc$', '\.class$', '\~$']

" delimitMate: disable on HTML/XML files
au FileType html,xml,gsp let b:delimitMate_autoclose = 0

" ctrlp: ignore folders
let g:ctrlp_custom_ignore = 'node_modules'

" -----------------------------------------------------------------------------
" ADDITIONAL FEATURES
" -----------------------------------------------------------------------------

set clipboard+=unnamed          " Yanks go on clipboard instead
set encoding=utf-8              " Default encoding UTF-8
set backspace=indent,eol,start  " Allow backspacing everything in insert mode

" Default formatting options
set expandtab
set textwidth=79
set tabstop=4
set shiftwidth=4
set softtabstop=4
set formatoptions-=t            " Don't force newlines at text width bounds

" Don't litter temporary files around filesystem, instead put them all in a
" single temp folder.
set backupdir=~/.vim_tmp
