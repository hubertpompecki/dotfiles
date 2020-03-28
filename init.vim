" " Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'sheerun/vim-polyglot'                                   " Syntax highlighting for multiple languages
Plug 'tpope/vim-surround'                                     " Adds surrounding operations
Plug 'tpope/vim-repeat'                                       " Supercharge '.' command
Plug 'tpope/vim-commentary'                                   " Easy commenting/uncommenting
Plug 'tpope/vim-fugitive'                                     " Git integration
Plug 'tpope/vim-eunuch'                                       " Helpers for UNIX
Plug 'ConradIrwin/vim-bracketed-paste'                        " Automatically set paste when pasting
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}    " Autocompletion
" Plug 'w0rp/ale'                                               " Lint as you type
Plug 'ap/vim-css-color'                                       " Colour colour names and codes
Plug 'christoomey/vim-tmux-navigator'                         " Easy navigating between tmux and vim
Plug 'terryma/vim-multiple-cursors'                           " Multiple cursors
Plug 'nanotech/jellybeans.vim'
Plug 'scrooloose/nerdtree'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'slashmili/alchemist.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'

" Initialize plugin system
call plug#end()




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



" ########## General neovim ##########

" Tell neovim where to find python3 so it boots up faster
let g:python3_host_prog = '/usr/local/bin/python3'



" ########## Ale ##########
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_javascript_eslint_use_global = 1



" ########## Other ##########

" Copy file name into clipboard
noremap <leader>f :let @*=expand("%")<CR>
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

" ########## Autocompletion coc.nvim
" if hidden is not set, TextEdit might fail.
set hidden

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" vmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR> ##########

" Run mix format on save
let g:mix_format_on_save = 1

" delcommand W
