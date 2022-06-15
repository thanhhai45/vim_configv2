Plug 'https://github.com/itchyny/lightline.vim'
Plug 'https://github.com/navarasu/onedark.nvim'
Plug 'NLKNguyen/papercolor-theme'


augroup ThemeOverride
    autocmd!
    autocmd User Plugloaded ++nested set background=light
    autocmd User Plugloaded ++nested colorscheme PaperColor
augroup end

let g:lightline = {
    \ 'colorscheme': 'PaperColor'
    \ }

