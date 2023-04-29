" vim-plug
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
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
Plug 'chrisbra/colorizer'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Mi config
set number relativenumber 
colorscheme catppuccin " catppuccin-mocha
set termguicolors
set cursorline
set cursorlineopt=number

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set smartindent
set smarttab
set autoindent
set cindent

" add indentation when pressing enter inside brackets
inoremap {<CR> {<CR>}<Esc>O
inoremap ( ()<Esc>i


" nerdtree close on open file 
let g:NERDTreeQuitOnOpen = 1


" keymaps
let mapleader = ","

nnoremap <silent> <C-l> :nohlsearch<CR>
nnoremap <silent> <C-e> :NERDTreeToggle<CR>

nnoremap <leader>e :NERDTreeToggle<CR>

imap <silent> <C-d> <Plug>(copilot-dismiss)
imap <silent> <C-n> <Plug>(copilot-next)
imap <silent> <C-p> <Plug>(copilot-previous)



" coc
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


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

" Set up linters and fixers for different programming languages
let g:ale_linters = {
    \ 'c': ['gcc'],
    \ 'cpp': ['clangd'],
    \ 'rust': ['analyzer'],
    \ 'python': ['pylint'],
    \ 'html': ['tidy'],
    \ 'php': ['php'],
    \ 'latex': ['chktex'],
    \}

let g:ale_fixers = {
    \ 'c': ['clang-format'],
    \ 'cpp': ['clang-tidy'],
    \ 'rust': ['rustfmt'],
    \ 'python': ['autopep8'],
    \ 'html': ['tidy'],
    \ 'php': ['phpcbf'],
    \ 'latex': ['latexindent'],
    \}

let g:ale_c_gcc_options = '-Wall -Wextra -std=c17 -I /usr/include/c++/12.2.1/'

" Set up key mappings for Ale commands
nnoremap <silent> <leader>l :ALELint<CR>
nnoremap <silent> <leader>f :ALEFix<CR>
"
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


" treesitter

lua << EOF
        require("nvim-treesitter.configs").setup({
            -- ensure_installed = "maintained",
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
            playground = {
                enable = true,
                disable = {},
                updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false, -- Whether the query persists across vim sessions
            },
        })
EOF

" let g:plug_timeout = 250
