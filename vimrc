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

  " For all text files set textwidth to 79 characters.
  autocmd FileType text setlocal textwidth=79

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

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" CUSTOM SETTINGS BELOW

" Pathogen initialization i.e. load bundle/*
call pathogen#infect()

" Default color scheme
colorscheme wombat256

" Line numbering
:set number

" Highlight current line
:set cursorline

" Allow SHIFT+h and SHIFT+l to cycle tabs
:map <S-h> gT
:map <S-l> gt

" columns ruler at text width
if exists("&colorcolumn")
  set colorcolumn=+1
  highlight ColorColumn ctermbg=8 guibg=gray35
endif

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" enable spell-checking for .txt files
autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us

" underline spelling mistakes
if version >= 700
  hi SpellBad   guisp=red    gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
  hi SpellCap   guisp=yellow gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
  hi SpellRare  guisp=blue   gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
  hi SpellLocal guisp=orange gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
endif

" F2 shortcut to open nerdtree file browser
map <F2> :NERDTreeToggle<CR>

" F5 shortcut to strip all trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Allow omnicomplete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" enable neocomplcache auto-completion plugin
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1 " wat?
let g:neocomplcache_enable_camel_case_completion = 1 " wat?
let g:neocomplcache_enable_underbar_completion = 1 " wat?
let g:neocomplcache_min_syntax_length = 3

" neocomplcache both closes pop-up and changes line on ENTER
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" neocomplcache close popup and delete backword char
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

" Auto-close preview window after omnifunction selection
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Yanks go on clipboard instead
set clipboard+=unnamed

" Files to ignore in Command-T and NERDTree
set wildignore+=*~,.git,*.pyc
let NERDTreeIgnore = ['\.pyc$', '\~$']

" Default encoding UTF-8
set encoding=utf-8

" Handier command mode shortcut
imap å <ESC>
vmap å <ESC>
smap å <ESC>

" Allow :W to write to file (capital w)
command! W write

" Easy split navigation (http://vimbits.com/bits/10)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Indent guide visually pleasing settings
let g:indent_guides_start_level=3
let g:indent_guides_guide_size=1

" Shortcut to rapidly toggle `set list`
set listchars=tab:▸\ ,eol:¬
nmap <leader>l :set list!<CR>

" Recomennded settings for powerline plugin
set laststatus=2
