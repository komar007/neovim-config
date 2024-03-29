set nocompatible
filetype off

call plug#begin()
Plug 'ryvnf/readline.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'hynek/vim-python-pep8-indent'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/conflict-marker.vim'
Plug 'vim-scripts/cscope_macros.vim'
Plug 'tpope/vim-fugitive'
Plug 'cloudhead/neovim-fuzzy'
Plug 'tpope/vim-sleuth'
Plug 'vim-scripts/a.vim'
Plug 'bogado/file-line'
Plug 'vim-scripts/camelcasemotion'
Plug 'mzlogin/vim-markdown-toc'
"Plug 'pangloss/vim-javascript'
"Plug 'maxmellon/vim-jsx-pretty'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdateSync'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-lua/plenary.nvim' " for telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'stevearc/dressing.nvim'
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'inkarkat/vim-ingo-library' " required by inkarkat/vim-EnhancedJumps
Plug 'inkarkat/vim-EnhancedJumps'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'sotte/presenting.vim'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

" -- neovide
set gfn=Jetbrains\ Mono\ Light:h9
set linespace=-4
let g:neovide_cursor_animation_length=0.07
let g:neovide_cursor_trail_size=0.05
let g:neovide_scroll_animation_length=0

filetype plugin indent on

" -- basic behaviour
set hidden
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
set sessionoptions=buffers,curdir,folds,tabpages
set ignorecase smartcase
set autoindent smartindent
set hlsearch incsearch
set grepprg=grep\ -nH\ $*
set cinoptions=:0,l1,t0,g0,N-s

autocmd BufEnter * let &titlestring = "vim - " . expand("%:t")
set title

" -- look and feel
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_italicize_comments=1
let g:gruvbox_underline=1
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
highlight Normal ctermbg=16 guibg=#000000
highlight Comment ctermfg=243 guifg=#7f7f7f
set cursorline
set number
set wildmenu
set wildmode=longest,list,list,full
set mouse=a
set mousemodel=extend
set timeoutlen=500
hi CursorLine ctermbg=237 guibg=#2c2826
hi CursorColumn ctermbg=237 guibg=#2c2826
hi! link StatusLine Normal
hi! link StatusLineNC Normal

setlocal spelllang=pl

map <F2> :set cursorcolumn!<CR>
map <F3> :IBLToggle<CR>

" -- filetype customs
autocmd FileType latex                setlocal spell
autocmd FileType c,cpp                compiler gcc
autocmd FileType c,cpp                set formatoptions=tcqlronj textwidth=78
autocmd FileType c,cpp,rust           set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType c,cpp                set errorformat=%f:%l:%c:\ error:\ %m,%f:%l:%c:\ warning:\ %m

nmap <Leader> :A<CR>

autocmd FileType pascal               compiler fpc
autocmd FileType haskell              set expandtab
autocmd FileType java,cs,python,json  set tabstop=4 shiftwidth=4 expandtab
autocmd FileType make                 set tabstop=8 shiftwidth=8 noexpandtab
autocmd FileType html,xhtml,eruby,xml set tabstop=2 shiftwidth=2 expandtab

autocmd BufNewFile,BufRead *.h,*.c set filetype=c

nnoremap <Leader>y mY"*yiw`Y

nmap <F7> :wall<cr>:make %< <cr>
nmap <F8> :wall<cr>:make <cr>
nmap <F4> :cprev <cr>
nmap <F5> :cnext <cr>

" -- highlighting stray whitespace
highlight ExtraWhitespace ctermbg=red guibg=#902020
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=#902020
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\|^\ [^*]?/
match ExtraWhitespace /\s\+$\|^\ [^*]?/
autocmd TermOpen,TermEnter * highlight clear ExtraWhitespace
autocmd TermLeave,TermClose * highlight ExtraWhitespace ctermbg=red guibg=#902020

highlight PmenuSel guifg=#ffffff ctermfg=236

let g:Tex_DefaultTargetFormat = 'pdf'

:command SanitizeXML :%s/>/>\r/g | :%s/</\r</g | :%g/^\s*$/d | :normal gg=G
:command FixStrays :%s/\(^\| \)\([auiwzoAUIWZO]\) /\1\2\~/g

set laststatus=2

let g:netrw_browsex_viewer = "chromium-browser"

set tags=./tags;/

" easier combo than ctrl+shift+6
nnoremap <silent> <C-6> <C-^>

if has("nvim")
    set inccommand=split
endif

set fillchars=vert:┆

" signs/gutter
set signcolumn=yes
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added = "▍"
let g:gitgutter_sign_removed = "◢"
let g:gitgutter_sign_modified = "▍"
let g:gitgutter_sign_modified_removed = "▍"
let g:gitgutter_sign_removed_first_line = "◥"
let g:gitgutter_eager = 1
let g:gitgutter_realtime = 1
highlight SignColumn guibg=#1d2021 ctermbg=16
highlight GitGutterAdd ctermfg=71 guifg=#5FAF5F
highlight GitGutterDelete ctermbg=16 guibg='#000000'
highlight GitGutterChange ctermfg=214 guifg=#FABD2F
highlight GitGutterChangeDelete ctermfg=202 guifg=#ff5f00

highlight DiagnosticSignError guifg='#3c3836' guibg='#fb4934' ctermfg=237 ctermbg=167 gui=bold
highlight DiagnosticSignHint guifg='#3c3836' guibg='#8ec07c' ctermfg=237 ctermbg=108
highlight DiagnosticSignInfo guifg='#3c3836' guibg='#83a598' ctermfg=237 ctermbg=109
highlight DiagnosticSignWarn guifg='#3c3836' guibg='#fabd2f' ctermfg=237 ctermbg=214 gui=bold

highlight DiagnosticSignErrorLine guibg='#331106'
highlight DiagnosticSignHintLine guibg='#062201'
highlight DiagnosticSignWarnLine guibg='#332206'

highlight LspReferenceText gui=reverse,bold cterm=reverse,bold
highlight LspReferenceWrite guifg='#df4432' ctermfg=red gui=reverse,bold cterm=reverse,bold
highlight LspReferenceRead guifg='#acaf26' ctermfg=green gui=reverse,bold cterm=reverse,bold

" diagnostics
lua <<END
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

local types = {"Error", "Warn", "Hint", "Info"}
for i,type in pairs(types) do
  local hl = "DiagnosticSign" .. type
  local lhl = "DiagnosticSign" .. type .. "Line"
  vim.fn.sign_define(hl, { numhl = hl, linehl = lhl })
end
END

highlight! link Pmenu Normal

set updatetime=500
if exists('+nocscopeverbose')
  set nocscopeverbose
endif

hi IblIndent ctermfg=235
" indent line
runtime indentline.lua

" telescope
runtime telescope.lua
nnoremap <C-p> :lua telescope_buffers()<CR>
nnoremap <Leader><C-p> :lua telescope_findfiles()<CR>
nnoremap <Leader>* :lua telescope_grep_string()<CR>
nnoremap <Leader>/ :lua telescope_live_grep()<CR>

runtime treesitter.lua
runtime lsp.lua

" nvim-cmp
set completeopt=menu,menuone,noselect
runtime completion.lua

" lualine.nvim configuration
runtime lualine.lua

" vsnip keys
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'


" next/prev problem
nnoremap <silent> ]l :lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> [l :lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> gl :lua vim.diagnostic.open_float()<CR>

" EnhancedJumps
let g:EnhancedJumps_no_mappings = 1
nmap <Leader><C-o> <Plug>EnhancedJumpsRemoteOlder
nmap <Leader><C-i> <Plug>EnhancedJumpsRemoteNewer

let g:tmux_navigator_no_mappings = 1
noremap <silent> <C-w>h :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <C-w>j :<C-U>TmuxNavigateDown<cr>
noremap <silent> <C-w>k :<C-U>TmuxNavigateUp<cr>
noremap <silent> <C-w>l :<C-U>TmuxNavigateRight<cr>
noremap <silent> <C-w><BS> :<C-U>TmuxNavigatePrevious<cr>

set scrolloff=10

:command Fmt lua vim.lsp.buf.format()
