"""BASIC SETTINGS"""{{{
""""""""""""""""""""
" Drop compatibility with vi
set nocompatible
" Why do I need to set this in current year???
set encoding=utf-8
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
set timeoutlen=600
" It's very weird that this is necessary because it's the default
" It allows backspace to delete over newlines and such
set backspace=indent,eol,start
" Follow first match while searching
set incsearch
" Highlight all search occurences
set hlsearch
nohlsearch
" Case insensitive searching
set ignorecase
" Hide buffer when switching to another one, instead of unloadng(?) it
" It allows faster file switches,
" preserving changelist when switching files, etc.
set hidden
" Don't use swap files, because they are pain to deal with.
set noswapfile
" Remember column when switching buffers
set nostartofline
" Marker folding
" set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldnestmax=1
set fillchars=fold:\ 
set foldtext=CustomFoldText()
function! CustomFoldText()
  " get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
      let line = getline(v:foldstart)
  else
      let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif
  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let foldLevelStr = repeat("+--", v:foldlevel)
  let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr) - 4)
  return line . " " . foldLevelStr . foldSizeStr
endfunction
autocmd FileType vim setlocal foldmethod=marker
" Set the title of the terminal to currently edited file
set title
set titlestring=%{split(getcwd(),'/')[-1]}:\ %f
" Display long lines that don't fit on the screen
set display+=lastline
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
" Fix incrementing numbers like 0.07
set nrformats-=octal
" Disable showing filename in statusline when opening files
set shortmess+=F
" Enable mouse support
set mouse=a
" Leave this amount of lines from the cursor to bottom/top of the screen
set scrolloff=5
" show statusline
set laststatus=2
" Show line number, column and position in file
" In lower right corner on the status line
set ruler
" Show commands in status line
set showcmd
" Interactive shell to get aliases
"set shellcmdflag=-ic
autocmd BufNewFile,BufRead *.pegphp set ft=pegjs
" When to insert a comment character
set formatoptions-=o
au BufEnter * set formatoptions-=o
autocmd FileType javascript setlocal ft=javascriptreact

autocmd FileType c setlocal path+=/usr/lib/gcc/x86_64-pc-linux-gnu/7.1.1/include
"""}}}

"""INDENTATION"""{{{
"""""""""""""""""
" Width of indentation (with commands like >>)
set shiftwidth=2
" Width of a tab
set tabstop=2
" Don't expand tabs into spaces (default)
set noexpandtab
" Set shorter tab width and use spaces for different file types
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType conf setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType haskell setlocal expandtab
autocmd FileType python setlocal expandtab
" Because default sass indent file overwrites it
" and 'autocmd FileType sass' or putting it in .vim/after/ftplugin
" are not working either
autocmd BufEnter *.sass setlocal noexpandtab shiftwidth=4
" Show whitespace
" set list
" ▶▸‒
set listchars=lead:·,tab:▶—,trail:·
"""}}}

"""PLUGINS"""{{{
"""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'michaelb/do-nothing.vim'
Plug 'SirVer/ultisnips'
" Using coc for emmet now
" Plug 'jceb/emmet.snippets'
" Plug 'mattn/emmet-vim'
"Plug 'vim-scripts/AutoComplPop'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"endif
"Plug 'terryma/vim-expand-region'
"Plug 'MichaelRFairhurst/angular-dep.vim'
Plug 'henrik/vim-indexed-search'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'
" Plug 'Raimondi/delimitMate'
" Plug 'jiangmiao/auto-pairs'
"Plug 'Valloric/ListToggle'
Plug 'maksimr/vim-jsbeautify'
Plug 'sheerun/vim-polyglot'
Plug 'Kazark/vim-SimpleSmoothScroll'
Plug 'tpope/vim-surround'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-scripts/nextval'
Plug 'kana/vim-textobj-user'
" Plug 'Julian/vim-textobj-variable-segment'
" This fork supports dashes:
Plug 'fuadsaud/vim-textobj-variable-segment'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'mhinz/vim-startify'
"Plug 'monaqa/dial.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'AndrewRadev/tagalong.vim'
Plug 'alvan/vim-closetag'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'alunny/pegjs-vim'
Plug 'chikamichi/mediawiki.vim'
Plug 'suy/vim-context-commentstring'
Plug 'Galooshi/vim-import-js'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
" Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'romainl/vim-devdocs'
Plug 'KabbAmine/vCoolor.vim'
" Plug 'lewis6991/gitsigns.nvim'
Plug 'airblade/vim-gitgutter'
" Plug 'f-person/git-blame.nvim'
" Plug 'ActivityWatch/aw-watcher-vim'
Plug 'Quramy/tsuquyomi'
Plug 'Quramy/tsuquyomi-vue'

if has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'sidebar-nvim/sidebar.nvim'
  " Plug 'neovim/nvim-lspconfig'
  " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'xuyuanp/scrollbar.nvim'
  Plug 'windwp/nvim-autopairs'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
  Plug 'lukas-reineke/indent-blankline.nvim'
endif

Plug 'NLKNguyen/papercolor-theme'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'rafi/awesome-vim-colorschemes'
call plug#end()
"""}}}

"""PLUGIN SPECIFIC SETTINGS"""{{{
""""""""""""""""""""""""""""""
"""NEOVIM PLUGIN SETUP"""

if has('nvim')
lua << EOF
require("sidebar-nvim").setup({
side = "right",
-- section_separator = {"", "-----", ""},
section_separator = {""},
sections = { "git", "diagnostics", "symbols", "todos" },
update_interval = 100,
})
-- require'lspconfig'.tsserver.setup{}
-- require'lspconfig'.vimls.setup{}
-- require'lspconfig'.cssls.setup{}
require('nvim-autopairs').setup{
map_bs = false,
}
-- require('gitsigns').setup()
-- Make autopairs CR work with coc completion's CR to confirm
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')
npairs.setup({map_cr=false})
-- skip it, if you use another global object
_G.MUtils= {}
MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    return vim.fn["coc#_select_confirm"]()
  else
    return npairs.autopairs_cr()
  end
end
remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
require("indent_blankline").setup{
show_current_context = true,
-- show_current_context_start = true,
show_trailing_blankline_indent = false,
}
vim.diagnostic.config({
virtual_text = false,
})
EOF
endif

"""vim-gitgutter"""
let g:gitgutter_map_keys = 0
set termguicolors
let g:gitgutter_signs=1
let g:gitgutter_highlight_lines=0
let g:gitgutter_highlight_linenrs=0
" set scl=number
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '┃'

"""vim-hexokinase"""
let g:Hexokinase_highlighters = ['backgroundfull']
"""scrollbar.nvim"""
if has('nvim')
	augroup ScrollbarInit
		autocmd!
		autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
		autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
		autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
	augroup end
endif
"""Vista"""
let g:vista_default_executive = "coc"
"""ranger.vim"""
let g:NERDTreeHijackNetrw = 0 " add this line if you use NERDTree
let g:ranger_replace_netrw = 1 " open ranger when vim open a directory
"""emmet-vim"""
" autocmd FileType javascript EmmetInstall
" let g:user_emmet_expandabbr_key='<Tab>'
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
"""vim-closetag"""
let g:closetag_filenames = "*.html,*.jsx,*.js,*.tsx,*.vue,*.xhml,*.xml"
"let g:closetag_regions = {
			"\ 'typescript.tsx': 'jsxRegion,tsxRegion',
			"\ 'javascript.jsx': 'jsxRegion',
			"\ }
"""coc"""
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
"""startify"""
let g:startify_change_to_vcs_root = 1
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
"""SUPERTAB"""
" Reverse the order of scrolling through completion list (tab moves downward)
let g:SuperTabDefaultCompletionType = '<C-n>'
"""LUALINE"""
"if has('nvim')
"lua << END
"require('lualine').setup({
"tabline = {
"lualine_a = { 'buffers' }
"}
"})
"END
"endif
"""AIRLINE"""
let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline_disable_statusline = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_left_sep="\uE0b0"
"let g:airline_right_sep="\uE0b2"
let g:airline_right_sep=""
"let g:airline#extensions#tabline#fnamemod = ':.'
let g:airline#extensions#tabline#fnamecollapse = 0
"if !has('nvim')
" Disable airline by default
"autocmd VimEnter * AirlineToggle
"endif
" Airline messes with this setting so we have to set it on VimEnter too
"autocmd VimEnter * set laststatus=0
" Nice themes:
" term, ravenpower, raven, powerlineish, murmur, wombat, kalisi, kolor,
" distinguished, dark
"let g:airline_theme='term'
let g:airline_theme='murmur'
"let g:airline_theme='tokyonight'
"let g:airline_theme='ayu'
"let g:airline_theme='deus'
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
"""TAGALONG"""
let g:tagalong_additional_filetypes = ['javascript']
"""vim-nerdtree-syntax-highlight"""
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeExactMatchHighlightColor = {}
let g:NERDTreeExactMatchHighlightColor['package.json'] = "905532"
"let g:NERDTreeSyntaxEnabledExactMatches = ['package.json']
"""}}}

"""APPEARANCE"""{{{
""""""""""""""""
" Color scheme
"colorscheme Tomorrow-Night-Bright
"colorscheme oceanictext
"colorscheme base16-oceanicnext
if (has("termguicolors"))
  " True color support for alacritty
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  " Use guicolors for highlighting. Allows to use true color.
  set termguicolors

  "colorscheme palenight

  let g:tokyonight_style = 'night' " available: night, storm
  let g:tokyonight_enable_italic = 0

  colo tokyonight
  hi Comment cterm=none gui=none
  hi Comment guifg=#646b8a
  hi Grey guifg=#646b8a
  hi LineNr guifg=#646b8a

  "colo ayu
  "" Adjustments for ayu
  "hi Comment guifg=#808B97
  "hi LineNr guifg=#eeeeee
  "" Whitespace color (listchars)
  "hi SpecialKey guifg=#33414E
  ""hi Normal guifg=#F0EBDA

  hi BufferInactive guifg=#6e738b guibg=#232433
endif
"colorscheme gruvbox
"set background=dark
"let g:gruvbox_italic = 0

" Inherit background color from the terminal
" Useful for preserving transparent background
highlight Normal ctermbg=none guibg=NONE
highlight EndOfBuffer ctermbg=none guibg=NONE
autocmd BufEnter * hi airline_tabfill ctermbg=NONE guibg=NONE
highlight Folded guifg=#FFFFFF
"hi airline_tabfill ctermbg=NONE guibg=NONE
hi CursorLine guibg=#2C2D40

" vim-gitgutter
" highlight GitGutterAdd guifg=#232433
" highlight GitGutterChange guifg=#232433
" highlight GitGutterDelete guifg=#232433
highlight GitGutterAddLineNr guifg=#9ECE6A
highlight GitGutterChangeLineNr guifg=#7AA2F7
highlight GitGutterDeleteLineNr guifg=#F7768E
" highlight GitGutterAddLineNr guibg=#9ECE6A guifg=#000000
" highlight GitGutterChangeLineNr guibg=#7AA2F7 guifg=#000000
" highlight GitGutterDeleteLineNr guibg=#F7768E guifg=#000000
" highlight GitGutterChangeDeleteLineNr guifg=lightred

" COC highlighting
"hi FgCocErrorFloatBgCocFloating guibg=#484951 guifg=#f7768e

"autocmd BufEnter * hi airline_tab_mod ctermbg=NONE guibg=NONE
"hi airline_c ctermbg=NONE guibg=NONE
"""}}}

"""KEY BINDINGS"""{{{
""""""""""""""""""
" Set the leader key
let mapleader=" "
command! -nargs=0 OI :silent call CocAction('runCommand', 'editor.action.organizeImport')
nmap <silent> gR <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <leader>i <Plug>(coc-diagnostic-info)
nnoremap <silent> <C-K> :call CocAction('doHover')<CR>
nmap <F2> <Plug>(coc-rename)
vmap <leader>a <Plug>(coc-codeaction)
nmap <leader>a <Plug>(coc-codeaction)
vnoremap <leader>f :Prettier<CR>
nnoremap <leader>f :Prettier<CR>
nnoremap <leader>o :SidebarNvimToggle<CR>
nnoremap <silent> <leader>c :Commentary<CR>
vnoremap <silent> <leader>c :Commentary<CR>
nnoremap <silent> + "+y
vnoremap <silent> + "+y
" Move lines (and reindent)
nnoremap <C-S-K> :<c-u>execute 'move -1-'. v:count1<cr>==
nnoremap <C-S-J> :<c-u>execute 'move +'. v:count1<cr>==
" vnoremap <C-S-K> :move -2<CR>gv
" vnoremap <C-S-J> :move '>+1<CR>gv
vnoremap <C-S-K> :<c-u>execute "'<,'>move -1-" . v:count1<CR>gv=gv
vnoremap <C-S-J> :<c-u>execute "'<,'>move '>+" . v:count1<CR>gv=gv
vnoremap < <gv
vnoremap > >gv

"nnoremap <C-p> :call FZFOpen(':Files')<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-S-a> :Buffers<CR>
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   "rg -g '!dist/' -g '!pnpm-lock.yaml' -g '!package-lock.json' -g '!.git' -g '!node_modules' -g '!builds/' --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
      \   fzf#vim#with_preview({'options': '--exact --delimiter : --nth 4..'}), <bang>0)
nnoremap <C-S-p> :Rg<CR>
nnoremap <C-c> "+y
vnoremap <C-c> "+y
nnoremap Q :q<CR>
" Load YouCompleteMe
nnoremap <leader>y :Loadycm<CR>
" Turn off search result highlighting until the next search
nnoremap <silent> <leader>h :nohlsearch<CR>
" Treat a wrapped line as multiple lines without breaking other commands
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
" Also clear search highlighting in minimap if it's loaded
if exists("loaded_minimap")
  nnoremap <leader>h :nohlsearch<CR>:call minimap#vim#ClearColorSearch()<CR>
endif
" Show buffer list and prepare :b for buffer switch
"nnoremap <C-b> :ls<CR>:b 
" Switching buffers
" nnoremap <C-h> :bp<CR>
" nnoremap <C-l> :bn<CR>
nnoremap <C-h> :BufferPrevious<CR>
nnoremap <C-l> :BufferNext<CR>
nnoremap <C-S-Tab> :BufferPrevious<CR>
nnoremap <C-Tab> :BufferNext<CR>
nnoremap <silent> <C-S-h> :BufferMovePrevious<CR>
nnoremap <silent> <C-S-l> :BufferMoveNext<CR>
nnoremap <silent> <C-1> :BufferGoto 1<CR>
nnoremap <silent> <C-2> :BufferGoto 2<CR>
nnoremap <silent> <C-3> :BufferGoto 3<CR>
nnoremap <silent> <C-4> :BufferGoto 4<CR>
nnoremap <silent> <C-5> :BufferGoto 5<CR>
nnoremap <silent> <C-6> :BufferGoto 6<CR>
nnoremap <silent> <C-7> :BufferGoto 7<CR>
nnoremap <silent> <C-8> :BufferGoto 8<CR>
nnoremap <silent> <C-9> :BufferGoto 9<CR>
" Delete buffer without closing current window
function! DeleteBuffer()
  bp
  try
    bd #
    " This occurs when current buffer is the last one
  catch /^Vim\%((\a\+)\)\=:E516:/
    bd
    return
    " If e.g. we can't delete buffer because it's not saved
  catch
    bn
    " Show the actual exception (aka rethrow)
    echoerr v:exception
  endtry
endfunction

" nnoremap <silent> <C-q> :call DeleteBuffer()<CR>
" plugin alternative:
nnoremap <silent> <C-q> :BufferClose<CR>
" nnoremap <silent> <leader>q :BufferClose<CR>
" nnoremap <leader>q :q<CR>
" Repeat last macro
nnoremap <C-2> @q
" nnoremap <C-q> @q
nnoremap <C-S-t> :e #<CR>

" nnoremap <leader>m :set mouse=<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>u :UltiSnipsEdit<CR>
nnoremap <leader>r :e ~/.vimrc<CR>
nnoremap <leader>R :source ~/.vimrc<CR>
"if has('nvim')
"nnoremap <leader>n :CHADopen<CR>
"nnoremap <C-n> :CHADopen<CR>
"else
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
"endif
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>d "_d
nnoremap <leader>D "_D
nnoremap <leader>x "_x
nnoremap <leader>X "_X
let s:showstatus = 0
function! ToggleStatus()
  "if !has('nvim')
  "AirlineToggle
  "endif
  if s:showstatus == 0
    set ruler
    set laststatus=2
    set showcmd
    "set showmode
    let s:showstatus=1
  else
    set noruler
    set laststatus=0
    set noshowcmd
    "set noshowmode
    let s:showstatus=0
  endif
endfunction
nnoremap <silent> <leader>s :call ToggleStatus()<CR>
" Show syntax highlighting groups for word under cursor
nnoremap <leader>p :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"nnoremap <leader><CR> :YcmCompleter FixIt<CR>:ccl<CR>
nnoremap <leader><CR> <Plug>(coc-codeaction)
"nnoremap <leader>f :silent :set nomore<Bar>:ls<Bar>:set more<CR>:b<Space>
"nnoremap <leader>f :ls<CR>:b<Space>
"nnoremap <C-n> :CtrlPBuffer<CR>
nnoremap <C-j> :join<CR>
noremap J 4j
noremap K 4k
" noremap <C-j> 4j
" noremap <C-k> 4k
imap <C-CR> <Esc>O

inoremap } }<ESC>mr=%`ra
inoremap <C-z> <ESC>ui
"""}}}

"""OTHER"""{{{
"""""""""""
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Hungry backspace
inoremap <silent><expr><bs> 
  \ (&indentexpr isnot '' ? &indentkeys : &cinkeys) =~? '!\^F' &&
  \ &backspace =~? '.*eol\&.*start\&.*indent\&' &&
  \ !search('\S','nbW',line('.')) ? (col('.') != 1 ? "\<C-U>" : "") .
  \ "\<bs>" . (getline(line('.')-1) =~ '\S' ? "" : "\<C-F>") : "\<bs>"
" autocmd BufNewFile,BufRead TODO set filetype=markdown
if has('nvim')
  autocmd TermOpen * startinsert
  au TermClose * call feedkeys("")
endif
" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
  if !exists("w:SavedBufView")
    let w:SavedBufView = {}
  endif
  let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Accept autocomplete entry with CR
" imap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

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

"command! Wsudo :w !sudo tee % >/dev/null
command! Wsudo :silent execute 'write !sudo tee ' . shellescape(@%, 1) . ' >/dev/null'
abbreviate wsudo Wsudo

abbreviate q qa

" Automatically :set paste when pasting
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

" This adds delay to Esc which is horrible
" inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" Fix vim deleting lines on Ctrl-Left and Right under alacritty
"map <ESC>[1;5A <C-Up>
"map <ESC>[1;5B <C-Down>
"map <ESC>[1;5C <C-Right>
"map <ESC>[1;5D <C-Left>
"imap <ESC>[1;5A <C-Up>
"imap <ESC>[1;5B <C-Down>
"imap <ESC>[1;5C <C-Right>
"imap <ESC>[1;5D <C-Left>
if !has('nvim')
  set term=xterm-256color
endif

" Don't clear clipboard on exit
autocmd VimLeave * call system('echo ' . shellescape(getreg('+')) . ' | xclip -selection clipboard')

" show/hide tab and statusline ui depending on number of open buffers
" BufAdd happens AFTER adding a buffer while BufDelete happens BEFORE deleting one
" Hence the weird numbuf comparisons
" !! not working...
"function! Show_ui()
"let numbuf = len(getbufinfo({'buflisted':1}))
"if numbuf >= 2 && s:showstatus == 0
"call ToggleStatus()
"endif
"endfunction
"function! Hide_ui()
"let numbuf = len(getbufinfo({'buflisted':1}))
"if numbuf <= 2 && s:showstatus == 1
"call ToggleStatus()
"endif
"endfunction

"autocmd! BufAdd * call Show_ui()
""autocmd! VimEnter * call Show_ui()
"autocmd! BufDelete * call Hide_ui()

function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
if(argc() == 0 && getcwd() != $HOME)
  au VimEnter * nested :call LoadSession()
  au VimLeave * :call MakeSession()
endif
"""}}}

"""NEOVIM"""{{{
""""""""""""
if has('nvim')
  set guicursor=a:block-blinkon1
endif
"""}}}
