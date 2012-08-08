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


" Pathogen initialization i.e. load bundle/*
call pathogen#infect()


" -----------------------------------------------------------------------------
" VISUAL SETTINGS
" -----------------------------------------------------------------------------

colorscheme wombat256       " Default color scheme
set number                  " Line numbering
set cursorline              " Highlight current line

" Visual color column at +1 of text width
if exists("&colorcolumn")
  set colorcolumn=+1
  highlight ColorColumn ctermbg=8 guibg=gray35
endif

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/


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
nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Handier command mode shortcut
imap å <ESC>
vmap å <ESC>
smap å <ESC>

" Shortcut to rapidly toggle `set list`
set listchars=tab:▸\ ,eol:¬
nmap <leader>l :set list!<CR>
hi NonText ctermfg=darkgray guifg=darkgray
hi SpecialKey ctermfg=darkgray guifg=darkgray ctermbg=234 guibg=#242424

" Allow :W to write to file (capital w)
command! W write

" Easy split navigation (http://vimbits.com/bits/10)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" -----------------------------------------------------------------------------
" PLUGIN SETTINGS
" -----------------------------------------------------------------------------

" Neocomplcache: Allow omnicomplete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Neocomplcache: Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" Neocomplcache: Enable auto-completion plugin
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1 " wat?
let g:neocomplcache_enable_camel_case_completion = 1 " wat?
let g:neocomplcache_enable_underbar_completion = 1 " wat?
let g:neocomplcache_min_syntax_length = 3

" Neocomplcache: Both closes pop-up and changes line on ENTER
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Neocomplcache: Close popup and delete backword char
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

" Neocomplcache: Auto-close preview window after omnifunction selection
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" NERDTree and CtrlP: ignore certain file types
set wildignore+=*~,.git,*.pyc
let NERDTreeIgnore = ['\.pyc$', '\~$']

" Powerline: recommended setting
set laststatus=2

" -----------------------------------------------------------------------------
" ADDITIONAL FEATURES
" -----------------------------------------------------------------------------

" Enable spell-checking for .txt files
autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us

" Underline spelling mistakes
if version >= 700
  hi SpellBad   guisp=red    gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
  hi SpellCap   guisp=yellow gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
  hi SpellRare  guisp=blue   gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
  hi SpellLocal guisp=orange gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
endif

set clipboard+=unnamed          " Yanks go on clipboard instead
set encoding=utf-8              " Default encoding UTF-8
set backspace=indent,eol,start  " Allow backspacing everything in insert mode

" Default formatting options
set expandtab
set textwidth=79
set tabstop=4
set shiftwidth=4
set softtabstop=4
