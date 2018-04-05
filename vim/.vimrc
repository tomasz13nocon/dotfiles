"""BASIC SETTINGS"""{{{
""""""""""""""""""""
" Drop compatibility with vi
set nocompatible
" Enable syntax highlighting
syntax enable
" Enable filetype specific plugins
" filetype on is set if it hasn't been already
" which enables filetype detection
filetype plugin on
" Display line numbers
set number
" Enable the autocompletion popup menu
set wildmenu
" Disable keycodes timeout (timeoutlen also affects mappings)
" so you don't have to wait 1 second
" e.g. for escape to exit visual mode
set ttimeoutlen=0
" It's very weird that this is necessary because it's the default
" It allows backspace to delete over newlines and such
set backspace=indent,eol,start
" Follow first match while searching
set incsearch
" Highlight all search occurences
set hlsearch
" Case insensitive searching
set ignorecase
" Show line number, column and position in file
" In lower right corner on the status line
set ruler
" Hide buffer when switching to another one, instead of unloadng(?) it
" It allows faster file switches,
" preserving changelist when switching files, etc.
set hidden
" Don't use swap files, because they are pain to deal with.
set noswapfile
" Remember column when switching buffers
set nostartofline
" Always show statusline
set laststatus=2
" Marker folding
set foldmethod=marker
" Display long lines that don't fit on the screen
set display+=lastline
set listchars+=tab:▶‒,trail:·
" For YCM to work with html ctags in css files.
" Unfortunately too many things break
"autocmd FileType css set filetype=html.css | set syntax=css
" Highligh current line in insert mode
" (causes lags if scrolling fast in normal mode)
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline
" Treat css classes with dashes as one word
autocmd FileType css,scss,sass setlocal iskeyword+=-
" Don't select first auto completion entry automatically
"set completeopt+=noselect
" Slightly improve performance
"set lazyredraw

autocmd FileType c setlocal path+=/usr/lib/gcc/x86_64-pc-linux-gnu/7.1.1/include
"""}}}

"""INDENTATION"""{{{
"""""""""""""""""
" Width of indentation (with commands like >>)
set shiftwidth=4
" Width of a tab
set tabstop=4
" Don't expand tabs into spaces (default)
set noexpandtab
" Set shorter indentation for html files
autocmd FileType html setlocal shiftwidth=2 tabstop=2
" Because default sass indent file overwrites it
" and 'autocmd FileType sass' or putting it in .vim/after/ftplugin
" are not working either
autocmd BufEnter *.sass setlocal noexpandtab shiftwidth=4
"""}}}

"""PLUGINS"""{{{
"""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'ctrlpvim/ctrlp.vim'
" Necessary for sane matching algorithm
Plug 'JazzCore/ctrlp-cmatcher'
Plug 'SirVer/ultisnips'
Plug 'jceb/emmet.snippets'
"Plug 'vim-scripts/AutoComplPop'
if has('nvim')
	Plug 'Shougo/deoplete.nvim'
else
	"Plug 'Valloric/YouCompleteMe', { 'on': [] }
	"Plug 'Valloric/YouCompleteMe', { 'for': 'css' }
endif
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"Plug 'terryma/vim-expand-region'
Plug 'MichaelRFairhurst/angular-dep.vim'
Plug 'henrik/vim-indexed-search'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
"Plug 'Valloric/ListToggle'
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'
Plug 'maksimr/vim-jsbeautify'
Plug 'Kazark/vim-SimpleSmoothScroll'
Plug 'tpope/vim-surround'

Plug 'drewtempelmeyer/palenight.vim'
call plug#end()
"""}}}

"""PLUGIN SPECIFIC SETTINGS"""{{{
""""""""""""""""""""""""""""""
"""CTRLP"""
" Disable changing ctrl-p root directory
" so that it always searches from cwd.
let g:ctrlp_working_path_mode = '0'
"""CTRLP-CMATCHER"""
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
"""ULTISNIPS"""
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<C-n>'
let g:UltiSnipsJumpBackwardTrigger='<C-p>'
let g:UltiSnipsSnippetsDir='~/.vim/UltiSnips'
"""YOUCOMPLETEME"""
" Lazy load
"command! Loadycm call plug#load('YouCompleteMe') | call youcompleteme#Enable() | Loadycm
command! Loadycm call plug#load('YouCompleteMe') | call youcompleteme#Enable()
" Close documentation window after completion
let g:ycm_autoclose_preview_window_after_completion = 1
"" Don't show annoying messages ("User defiend completion, pattern not found")
set shortmess+=c
"" Let supertab handle tab completion
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"" ctags support
"let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_semantic_triggers = {
	\   'css': [ 're!^\s{1,4}', 're!:\s+' ],
	\   'sass': [ 're!^\s+', 're!:\s+' ],
	\ }
highlight YcmErrorSign ctermbg=1
highlight SpellBad ctermbg=none
highlight SpellBad ctermfg=9
highlight SpellBad cterm=underline
let g:ycm_extra_conf_globlist = ['~/.ycm_extra_conf.py']
let g:ycm_always_populate_location_list = 1
let g:ycm_error_symbol = '>'
let g:ycm_warning_symbol = '>'
let g:ycm_enable_diagnostic_signs = 0
"""DEOPLETE"""
let g:deoplete#enable_at_startup = 1
"""SUPERTAB"""
" Reverse the order of scrolling through completion list (tab moves downward)
let g:SuperTabDefaultCompletionType = '<C-n>'
"""AIRLINE"""
let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
" Nice themes:
" term, ravenpower, raven, powerlineish, murmur, wombat, kalisi, kolor,
" distinguished, dark
"let g:airline_theme='term'
let g:airline_theme='murmur'
"let g:airline_theme='gruvbox'
"let g:airline_theme='dark'
"""NERDCOMMENTER"""
let g:NERDSpaceDelims = 0
"""DELIMITMATE"""
let delimitMate_expand_cr = 1
au FileType python let b:delimitMate_nesting_quotes = ['"']
"""ListToggle"""
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>L'
"""BROWSERLINK"""
let g:bl_pagefiletypes = ['html']
let g:bl_no_css_reload = 1
"""JSBEAUTIFY"""
command! JsBeautify call JsBeautify()
"""}}}

"""APPEARANCE"""{{{
""""""""""""""""
" Use guicolors for highlighting. Allows to use true color.
set termguicolors
" Color scheme
"colorscheme Tomorrow-Night-Bright
"colorscheme oceanictext
"colorscheme base16-oceanicnext
colorscheme palenight
"colorscheme gruvbox
"set background=dark
"let g:gruvbox_italic = 0
" Inherit background color from the terminal
" Useful for preserving transparent background
highlight Normal ctermbg=none
"""}}}

"""KEY BINDINGS"""{{{
""""""""""""""""""
" Set the leader key
let mapleader=" "
" Load YouCompleteMe
nnoremap <leader>y :Loadycm<CR>
" Turn off search result highlighting until the next search
nnoremap <leader>h :nohlsearch<CR>
" Show buffer list and prepare :b for buffer switch
"nnoremap <C-b> :ls<CR>:b 
" Switching buffers
nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>
" Delete buffer without closing current window
function! DeleteBuffer()
	bp
	try
		bd #
	" This occurs when current buffer is the last one
	catch E516
		bd
		return
	" If e.g. we can't delete buffer because it's not saved
	catch
		bn
		" Show the actual exception (aka rethrow)
		echoerr v:exception
	endtry
endfunction
nnoremap <C-q> :call DeleteBuffer()<CR>
nnoremap <leader>q :call DeleteBuffer()<CR>
" Repeat last macro
nnoremap <C-@> @@

nnoremap <leader>w :w<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>u :UltiSnipsEdit<CR>
nnoremap <leader>r :e ~/.vimrc<CR>
nnoremap <leader>R :source ~/.vimrc<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>d "_d
"nnoremap <leader>c "_c
nnoremap <leader>x "_x
" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <leader>p :call <SID>SynStack()<CR>
nnoremap <leader><CR> :YcmCompleter FixIt<CR>:ccl<CR>
"nnoremap <leader>f :silent :set nomore<Bar>:ls<Bar>:set more<CR>:b<Space>
nnoremap <leader>f :ls<CR>:b<Space>
nnoremap <C-n> :CtrlPBuffer<CR>
nnoremap <C-j> :join<CR>
noremap J 4j
noremap K 4k

inoremap } }<ESC>mr=%`ra

inoremap <C-z> <ESC>ui
"""}}}

"""OTHER"""{{{
"""""""""""
" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif

command! Wsudo :w !sudo tee %
abbreviate wsudo Wsudo

abbreviate q qa
"""}}}

"""NEOVIM"""{{{
""""""""""""
if has('nvim')
	set guicursor=a:block-blinkon1
endif
"""}}}
