call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'ycm-core/YouCompleteMe', {'do': './install.py'}
Plug 'dense-analysis/ale'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'itchyny/lightline.vim'
Plug 'github/copilot.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'lervag/vimtex'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rust-lang/rust.vim'
call plug#end()


" Mi config
set number relativenumber 
colorscheme catppuccin " catppuccin-mocha
set termguicolors
set cursorline
set cursorlineopt=number
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" keymaps
let mapleader = ","

nnoremap <silent> <C-l> :nohlsearch<CR>
nnoremap <silent> <C-e> :NERDTreeToggle<CR>

nnoremap <leader>e :NERDTreeToggle<CR>
imap <silent> <C-d> <Plug>(copilot-dismiss)
imap <silent> <C-n> <Plug>(copilot-next)
imap <silent> <C-p> <Plug>(copilot-previous)


" ycm
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_semantic_triggers = {'c,cpp,python,rust,html,markdown ': ['.']}
let g:ycm_filetype_blacklist = {}


" Enable ALE.
let g:ale_enabled = 1

" Show errors in the gutter.
" let g:ale_sign_error = '✖'
"let g:ale_sign_error = '▇'
let g:ale_sign_error = '>'
let g:ale_sign_warning = '>'

" Show errors in the location list.
let g:ale_list_window_size = 5
let g:ale_list_vertical = 1

" Enable error highlighting.
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '▇[%linter%] %s (%severity%)'

" Map keys to navigate errors.
nnoremap <silent> <leader>ne :ALENext<CR>
nnoremap <silent> <leader>pe :ALEPrevious<CR>


" lightline
let g:lightline = {
      \ 'colorscheme': 'catppuccin',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'fugitive#head',
      \ },
      \ }

" vimtex
filetype plugin indent on
let g:vimtex_view_method = 'zathura'
syntax enable
