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

" MAP KEY
let mapleader=" "
" Save
nmap <leader>w :w<CR>
" Close
nmap <leader>q :q<CR>
" Clean mark from previus search
nnoremap <silent> <leader>z :nohlsearch<CR>

"############## INSTALL PLUGIN ###############"
call plug#begin('~/.vim/plugged')

" Theme
Plug 'ayu-theme/ayu-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" React
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

Plug 'ryanoasis/vim-devicons' " Icons over NerdTree
Plug 'easymotion/vim-easymotion' " Move between words (space+m)
Plug 'christoomey/vim-tmux-navigator' " Move between words (ctrl+{h,j,k,l})
Plug 'Yggdroot/indentLine' " Identline
Plug 'scrooloose/nerdtree' " Menu dir (<F2>)
Plug 'jiangmiao/auto-pairs' " Automatic quote and bracket completion
Plug 'scrooloose/nerdcommenter' " Commentary
Plug 'mattn/emmet-vim' " Auto close tags html and jsx (,+,)

Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" Prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['htmldjango'] }

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-git',
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-sh',
  \ ]

call plug#end()

" THEME
set termguicolors     " enable true colors support
let ayucolor="dark"
colorscheme ayu
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

" Prettier
let g:prettier#config#use_tabs = 'false'
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css,js,hbs,ejs,htmldjango EmmetInstall
let g:user_emmet_leader_key=','

" Easymotion
nmap <leader>m <Plug>(easymotion-s2)

" Nerdtree
let g:NERDTreeChDirMode = 2
nmap <F2> :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1

" NerdCommenter
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1

" Identline
let g:indentLine_fileTypeExclude = ['text', 'help', 'terminal']
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']

" Coc
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2 " Give more space for displaying messages.
set updatetime=300
set shortmess+=c

" GoTo code navigation
nnoremap <silent> K :call CocAction('doHover')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" CocAction
nmap <leader>ca <Plug>(coc-codeaction)

" Coc-Prettier
nmap <leader>f :CocCommand prettier.formatFile<CR>

" Coc-Python exec in terminal
nmap <leader>pr :CocCommand python.execInTerminal<CR>
