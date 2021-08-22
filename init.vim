set number
set colorcolumn=80
set autoindent
set smartindent
set incsearch
set list
set listchars=tab:--,trail:·,eol:¬,nbsp:_
let g:indent_blankline_space_char='-'


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
EOF
