set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
syntax enable
set showcmd
set cursorline
set encoding=utf-8
set showmatch
set sw=2
set relativenumber
set laststatus=2
set noshowmode

" --- Terminal inside neovim
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
    "split term://zsh
    split term://bash
    resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

"############## INSTALL PLUGIN ###############"
call plug#begin('~/.vim/plugged')
" ----- IDE:
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'} " Conquer Of Completion
Plug 'ryanoasis/vim-devicons' " VIM-DEVICONS icons for NERDTree
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'easymotion/vim-easymotion' " Move between words (space+m)
Plug 'christoomey/vim-tmux-navigator' " Move between words (ctrl+{h,j,k,l})
Plug 'Yggdroot/indentLine' " Identline
Plug 'scrooloose/nerdtree' " Menu dir (<F2>)
Plug 'jiangmiao/auto-pairs' " Automatic quote and bracket completion
Plug 'scrooloose/nerdcommenter' " Commentary
Plug 'mattn/emmet-vim' " Auto close tags html and jsx (,+,)

"" -- Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" -- Javascript
Plug 'yuezk/vim-js' " Syntax highlighting for js
Plug 'maxmellon/vim-jsx-pretty' " Syntax highlighting for jsx
Plug 'HerringtonDarkholme/yats.vim' " Syntax highlighting for ts

" -- Flutter
"Plug 'dart-lang/dart-vim-plugin'

"Prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'htmldjango'] }

" -- Rust
Plug 'rust-lang/rust.vim'

" -- Style
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim'

call plug#end()

" ----- CONFIG
" -- Style
set termguicolors  " Activa true colors en la terminal
colorscheme dracula
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

" -- MAP KEY
let mapleader=" "
" Save
nmap <leader>w :w<CR>
" Close
nmap <leader>q :q<CR>
" Clean mark from previus search
nnoremap <silent> <leader>z :nohlsearch<CR>

" -- Emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css,js,hbs,ejs,htmldjango EmmetInstall
let g:user_emmet_leader_key=','

" -- Easymotion
nmap <leader>s <Plug>(easymotion-s2)

" -- Nerdtree
let g:NERDTreeChDirMode = 2
nmap <F2> :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1

" -- Rust
let g:rust_clip_command = 'xclip -selection clipboard'

" -- NerdCommenter
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1

" -- Identline
let g:indentLine_fileTypeExclude = ['text', 'help', 'terminal']
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']

"-- Prettier
let g:prettier#config#use_tabs = 'false'

" -- COC
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2 " Give more space for displaying messages.
set updatetime=300
set shortmess+=c

" plugin coc
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-git', 'coc-prettier', 'coc-python', 'coc-sh', 'coc-flutter']

    " Format code
nmap <leader>f :CocCommand prettier.formatFile<CR>
    " Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

