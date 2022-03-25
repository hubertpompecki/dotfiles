" " Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neovim/nvim-lspconfig'                                  " Language server
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}                     " Autocompletion
Plug '/usr/local/opt/fzf'                                     " File finding
Plug 'junegunn/fzf.vim'                                       " File finding
Plug 'sheerun/vim-polyglot'                                   " Syntax highlighting for multiple languages
Plug 'tpope/vim-surround'                                     " Adds surrounding operations
Plug 'tpope/vim-repeat'                                       " Supercharge '.' command
Plug 'tpope/vim-commentary'                                   " Easy commenting/uncommenting
Plug 'tpope/vim-fugitive'                                     " Git integration
Plug 'tpope/vim-eunuch'                                       " Helpers for UNIX
Plug 'ConradIrwin/vim-bracketed-paste'                        " Automatically set paste when pasting
Plug 'ap/vim-css-color'                                       " Colour colour names and codes
Plug 'christoomey/vim-tmux-navigator'                         " Easy navigating between tmux and vim
Plug 'terryma/vim-multiple-cursors'                           " Multiple cursors
Plug 'nanotech/jellybeans.vim'                                " Colour scheme
Plug 'scrooloose/nerdtree'                                    " File tree
Plug 'JamshedVesuna/vim-markdown-preview'                     " Markdown
Plug 'elixir-editors/vim-elixir'                              " Elixir utils
Plug 'mhinz/vim-mix-format'                                   " Mix format

" Initialize plugin system
call plug#end()

lua << EOF
local lspconfig = require("lspconfig")
local path_to_elixirls = vim.fn.expand("~/elixir-ls/rel/language_server.sh")

lspconfig.elixirls.setup({
  cmd = {path_to_elixirls},
  capabilities = capabilities,
  on_attach = on_attach,
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
EOF

" Needs to so that going to definition can change buffers
set hidden
nmap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
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
" Easily show current file in NERDTree
nnoremap ,f :NERDTreeFind<CR>
" Easily open NERDTree
nnoremap ,n :NERDTreeToggle<CR>
" Preview Markdown using grip
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=2
let vim_markdown_preview_github=1
" Run mix format on save
let g:mix_format_on_save = 1
" Fixes vim-tmux-navigator conflicting with coq_nvim
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
