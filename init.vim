" " Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neovim/nvim-lspconfig'                                  " Language server
Plug 'ms-jpq/coq_nvim'                                        " Autocompletion, using a commit version due to freezes
" Plug 'ms-jpq/coq_nvim', {'commit': '5eddd3'}                " BACKUP Autocompletion, using a commit version due to freezes
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}          " Autocompletion snippets
Plug '/usr/local/opt/fzf'                                     " File finding
Plug 'junegunn/fzf.vim'                                       " File finding
Plug 'sheerun/vim-polyglot'                                   " Syntax highlighting for multiple languages
Plug 'tpope/vim-surround'                                     " Adds surrounding operations
Plug 'tpope/vim-repeat'                                       " Supercharge '.' command
Plug 'tpope/vim-commentary'                                   " Easy commenting/uncommenting
Plug 'tpope/vim-fugitive'                                     " Git integration
Plug 'tpope/vim-rhubarb'                                      " GBrowse for GitHub
Plug 'tpope/vim-eunuch'                                       " Helpers for UNIX
Plug 'ConradIrwin/vim-bracketed-paste'                        " Automatically set paste when pasting
Plug 'ap/vim-css-color'                                       " Colour colour names and codes
Plug 'christoomey/vim-tmux-navigator'                         " Easy navigating between tmux and vim
Plug 'terryma/vim-multiple-cursors'                           " Multiple cursors
Plug 'nanotech/jellybeans.vim'                                " Colour scheme
Plug 'elixir-editors/vim-elixir'                              " Elixir utils
"Plug 'mhinz/vim-mix-format'                                   " Mix format
Plug 'lukas-reineke/lsp-format.nvim'
Plug 'github/copilot.vim'                                     " AI copilot

" Initialize plugin system
call plug#end()

" Enable copilot
let b:copilot_enabled = v:true

" jump to mark is disabled because it's set to <c-h> by default which conflicts with
" vim-tmux-navigator
" recommended keymaps are disabled because they conflict with copilot
let g:coq_settings = {'auto_start': v:true, 'keymap.jump_to_mark': '<c-0>', "keymap.recommended": v:false}

" Keybindings
ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
" ino <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"

lua << EOF
local coq = require("coq")
local lspconfig = require("lspconfig")
local path_to_elixirls = vim.fn.expand("~/elixir-ls/release/elixir-ls")

require("lsp-format").setup {}

lspconfig.elixirls.setup({
  cmd = {path_to_elixirls},
  capabilities = capabilities,
  on_attach = require("lsp-format").on_attach,
  settings = {
    elixirLS = {
      -- I choose to disable dialyzer for personal reasons, but
      -- I would suggest you also disable it unless you are well
      -- aquainted with dialzyer and know how to use it.
      dialyzerEnabled = false,
      -- I also choose to turn off the auto dep fetching feature.
      -- It often get's into a weird state that requires deleting
      -- the .elixir_ls directory and restarting your editor.
      fetchDeps = false
    }
  }
})

require'lspconfig'.gopls.setup{ on_attach = require("lsp-format").on_attach }
EOF

" Needs to so that going to definition can change buffers
set hidden
nmap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
nmap <silent> ? <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>
nmap <silent> K <cmd>lua vim.lsp.buf.hover()<cr>

" ########## General vim ##########
let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}
if has('termguicolors') && &termguicolors
    let g:jellybeans_overrides['background']['guibg'] = 'none'
endif
:colorscheme jellybeans
" Enable mouse support
set mouse=a
" Enable file type detection
filetype plugin on
" Convert a tab to two spaces
set expandtab
set tabstop=2
" Use 2 spaces for default indentation
set shiftwidth=2
" Override for Go
autocmd FileType go setlocal ts=4  shiftwidth=4
" Show line numbers
set number
set numberwidth=4
:highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
" Open new vertical splits to the right
set splitright
set foldmethod=syntax
set foldlevelstart=99
" Tell neovim where to find python3 so it boots up faster
let g:python3_host_prog = '/usr/local/bin/python3'
" Copy file name into clipboard
noremap <leader>f :let @*=expand("%")<CR>
" Copy to system clipboard
noremap <leader>c "*y<CR>
" Open fzf with ctrl p
nnoremap <C-p> :GFiles<CR>
" Open history
nnoremap <leader>h :History<CR>
" Open buffers
nnoremap <leader>b :Buffers<CR>
" Easily clear highligt
nnoremap ,<space> :noh<CR>
" Run mix format on save
let g:mix_format_on_save = 1
" Exit terminal with Esc
:tnoremap <Esc> <C-\><C-n>
" Disable line numbers in terminal
autocmd TermOpen * setlocal nonumber norelativenumber
