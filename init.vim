" line number
set number

" show print margin
set colorcolumn=80

" indentation
set autoindent
set smartindent

" highlight as you search
set incsearch

" show list mode and set whitespace chars
set list
set listchars=tab:--,trail:·,eol:¬,nbsp:_
let g:indent_blankline_space_char='-'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" keybindings that autoclose opening quotes, braces, etc.
inoremap \" \"\"<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O


" the below commands are executed upon entering nvim for all 
" filetypes

" using colorscheme gotham fails unless it's fed to autocmd
autocmd VimEnter * colorscheme gotham

" set transparency effects for the editor
autocmd VimEnter * highlight Normal ctermbg=NONE
autocmd VimEnter * highlight NonText ctermbg=NONE


" vim-plug code below 
" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Statusline and icons 
 Plug 'hoob3rt/lualine.nvim'
 Plug 'kyazdani42/nvim-web-devicons'
" Better syntax highlighting
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" Indentation help -- shows lines for indents
 Plug 'lukas-reineke/indent-blankline.nvim'
" Common configuration for Neovim's built-int LSP protocol
 Plug 'neovim/nvim-lspconfig'
" Autocompletion tool, hover windows, and more
 Plug 'nvim-lua/completion-nvim'
" Themes
 Plug 'whatyouhide/vim-gotham'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" use this syntax to require lua modules
lua <<EOF
require('lualine').setup()
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "rust", "javascript" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
require'lspconfig'.pyright.setup{}
require('indent_blankline').setup {
	char = "|",
	buftyper_exclue = {"terminal"},
}
require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.ccls.setup {on_attach=require'completion'.on_attach,
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
}
EOF
