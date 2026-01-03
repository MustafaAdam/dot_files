" ================================
" Neovim Init - Cleaned Base Config
" ================================

" ----------------
" Vim-Plug: Plugin Manager
" ----------------
call plug#begin('~/.local/share/nvim/plugged')

" ================================
" Aesthetics / Themes / Visual Enhancements
" ================================
Plug 'morhetz/gruvbox'                     " Popular color scheme, dark/light modes
Plug 'junegunn/seoul256.vim'               " Alternative color scheme

" ================================
" Functional / Productivity Plugins
" ================================
Plug 'tpope/vim-fugitive'                  " Git integration inside Neovim
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'                  " Easy manipulation of brackets, quotes, etc.
Plug 'majutsushi/tagbar'                    " Shows tags / symbols in a sidebar
Plug 'preservim/nerdtree'                  " File explorer tree
Plug 'preservim/nerdcommenter'             " Easy code commenting/uncommenting
Plug 'jiangmiao/auto-pairs'                 " Auto-close brackets, quotes, etc.
Plug 'junegunn/vim-easy-align'             " Column alignment tool
Plug 'alvan/vim-closetag'                   " Auto-close HTML/XML tags
Plug 'tpope/vim-abolish'                    " Search/replace and case coercion enhancements
Plug 'Yggdroot/indentLine'                  " Vertical indentation guides
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }   " Fuzzy finder core
Plug 'junegunn/fzf.vim'                     " FZF integration for Neovim
Plug 'chrisbra/Colorizer'                   " Highlight color codes in files
Plug 'SirVer/ultisnips'                     " Snippet engine
Plug 'honza/vim-snippets'                   " Predefined snippets for Ultisnips

" ================================
" Entertainment / Fun
" ================================

call plug#end()   " End plugin section

" ----------------
" Python3 VirtualEnv for Plugins
" ----------------
let g:python3_host_prog = expand('~/.config/nvim/venv/bin/python')  " Python3 interpreter for plugins like Ultisnips, deoplete, etc.

" ----------------
" Core Neovim Settings
" ----------------
syntax on                              " Enable syntax highlighting
filetype plugin indent on              " Enable filetype-specific indentation
set clipboard=unnamedplus               " yank (y) and (p) paste go to and come from clipboard
set termguicolors                       " Enable true color support
set background=dark                     " Default background mode
set encoding=utf-8                      " File encoding
set number                              " Show line numbers
set ruler                               " Show cursor position
set laststatus=2                        " Always show status line
set showcmd                             " Show command in status line
set showmode                            " Show current mode
set title                               " Terminal title reflects file name
set list listchars=trail:»,tab:»-       " Visualize trailing spaces and tabs
set fillchars+=vert:\                    " Vertical split character
set wrap breakindent                     " Soft wrap with indentation
set tabstop=4                            " Width of tab character
set softtabstop=4                        " Tab key behaves like 4 spaces
set shiftwidth=4                         " Indent size for >> << commands
set expandtab                            " Use spaces instead of tabs
set smarttab                             " Make <Tab> smarter
set autoindent                           " Auto-indent new lines
set incsearch                            " Incremental search
set ignorecase                           " Case-insensitive search
set smartcase                            " Case-sensitive if uppercase letters used
set hlsearch                             " Highlight search matches

" ----------------
" Colorscheme & Highlight tweaks
" ----------------
colorscheme gruvbox                        " Default colorscheme; replace with 'gruvbox' or another installed theme
highlight Pmenu guibg=white guifg=black gui=bold    " Popup menu colors
highlight Comment gui=bold                         " Bold comments
highlight Normal gui=none                           " Normal text highlight

" ----------------
" Plugin Settings Explained
" ----------------

" NERDTree
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'


" Ultisnips (snippets)
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<C-x>"

" EasyAlign (column alignment)
xmap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

" indentLine (vertical indentation guides)
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#363949'

" TagBar (code symbols sidebar)
let g:tagbar_width = 30
let g:tagbar_iconchars = ['↠', '↡']

" fzf-vim (fuzzy finder)
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_colors =
\ { 'fg': ['fg', 'Normal'], 'bg': ['bg', 'Normal'], 'hl': ['fg', 'Comment'],
  \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'], 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+': ['fg', 'Statement'], 'info': ['fg', 'Type'], 'border': ['fg', 'Ignore'],
  \ 'prompt': ['fg', 'Character'], 'pointer': ['fg', 'Exception'], 'marker': ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'], 'header': ['fg', 'Comment'] }


" Airline minimal setup

" Let airline auto-handle sections
" Optional: tweak colorscheme
let g:airline_theme='gruvbox'


" ----------------
" Custom Functions
" ----------------
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e          " Remove trailing spaces
    call winrestview(l:save)
endfunction

" ----------------
" Key Mappings / Shortcuts
" ----------------
let mapleader=","                     " Leader key
nnoremap <leader>q :NERDTreeToggle<CR>   " Toggle NERDTree
nnoremap <leader>w :w<CR>                " Save file
nnoremap <leader><leader> :q!<CR>       " Quit without saving
nnoremap \ <leader>q
nnoremap <leader>t :call TrimWhitespace()<CR>  " Remove trailing spaces
xmap <leader>a gaip*                       " EasyAlign visual mode
nnoremap <leader>a gaip*                       " EasyAlign normal mode
nnoremap <leader>s <C-w>s<C-w>j:terminal<CR>  " Split horizontal terminal
nnoremap <leader>vs <C-w>v<C-w>l:terminal<CR> " Split vertical terminal
nnoremap <leader>f :Files<CR>                  " FZF file search
nnoremap <leader>j :set filetype=journal<CR>  " Set filetype to journal
autocmd FileType python nnoremap <leader>x :0,$!~/.config/nvim/env/bin/python -m yapf<CR>  " Format Python file
nnoremap <leader>n :NERDTree<CR>             " Open NERDTree
nnoremap <silent> <leader>h :noh<CR>        " Clear search highlights
nnoremap <Tab> :bnext<CR>                    " Switch to next buffer
nnoremap <S-Tab> :bprevious<CR>              " Switch to previous buffer

tnoremap <Esc> <C-\><C-n>                    " ESC exits insert mode
