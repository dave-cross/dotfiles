" Add default colorscheme here so we can override later.
syntax enable
filetype plugin indent on
set term=xterm-256color
set termguicolors
set background=dark
colorscheme desert

" Try to load minpac.
packadd minpac

if !exists('g:loaded_minpac')
  " minpac is not available.

  " Settings for plugin-less environment.
  " Try installing minpac and reloading vimrc.
  silent execute '!git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac'
  source ~/.vimrc

endif


"minpac is available.
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" Airline
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
" Update colorscheme to use plugin
" call minpac#add('crusoexia/vim-monokai')
call minpac#add('gruvbox-community/gruvbox')
colorscheme gruvbox

" Install FZF and set up commands
call minpac#add('junegunn/fzf', { 'do': 'packloadall! | call fzf#install()' })
call minpac#add('junegunn/fzf.vim')
nnoremap <C-p> :<C-u>FZF<CR>

" Linting
" call minpac#add('dense-analysis/ale')
" let js_fixers = ['prettier', 'eslint']

" let g:ale_fixers = {
"       \   '*': ['remove_trailing_lines', 'trim_whitespace'],
"       \   'javascript': js_fixers,
"       \   'javascript.jsx': js_fixers,
"       \   'typescript': js_fixers,
"       \   'typescriptreact': js_fixers,
"       \   'css': ['prettier'],
"       \   'json': ['prettier'],
"       \}
" let g:ale_linters = {
"       \   'javascript': ['eslint', 'prettier'],
"       \   'javascript.jsx': ['eslint', 'prettier'],
"       \   'typescript': ['eslint', 'tsserver'],
"       \   'typescriptreact': ['eslint', 'tsserver'],
"       \}

" let g:ale_typescript_prettier_use_local_config = 1
" let g:ale_fix_on_save = 1
" " let g:airline#extensions#ale#enabled = 1
" " let g:ale_virtualtext_cursor = 1
" " let g:ale_virtualtext_prefix = "🔥 "
" let g:ale_sign_column_always = 1
" let g:ale_completion_autoimport = 1
" let g:ale_lsp_suggestions = 1
" let g:ale_floating_preview = 1
" let g:ale_linters_explicit = 1

" let g:ale_sign_error = "🐛"
" let g:ale_sign_warning = "⚠️"
" let g:ale_sign_info = "ℹ"

" " augroup ale-colors
"   " highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#C30500
"   " highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237
" " augroup END


" command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"

call minpac#add('neoclide/coc.nvim', {"branch": "release"})
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Javascript highlighting
call minpac#add('pangloss/vim-javascript')
call minpac#add('leafgarland/typescript-vim')
call minpac#add('MaxMEllon/vim-jsx-pretty')
call minpac#add('peitalin/vim-jsx-typescript')
call minpac#add('jparise/vim-graphql')
" call minpac#add('ianks/vim-tsx')
call minpac#add('leshill/vim-json')
call minpac#add('evanleck/vim-svelte')

" NerdCommenter
call minpac#add('scrooloose/nerdcommenter')
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

call minpac#add('tpope/vim-surround')
call minpac#add('jiangmiao/auto-pairs')

" Emmet
call minpac#add('mattn/emmet-vim')
imap <expr> <tab> emmet#expandAbbrIntelligent("\<C-e>")

" Respect .editorconfig files. (http://editorconfig.org/)
call minpac#add('editorconfig/editorconfig-vim')


" TODO: Should the above be in a seperate "install" script?

" Settings
set encoding=utf-8
set fileencoding=utf-8

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
set signcolumn=yes
set modelines=0
set scrolloff=8
set number
set relativenumber

set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

set is hls

set wildmenu
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*

" Autocommands
function! SetTerminalTitle()
    let titleString = expand('%:t')
    if len(titleString) > 0
        let &titlestring = expand('%:t')
        " this is the format iTerm2 expects when setting the window title
        let args = "\033];".&titlestring."\007"
        let cmd = 'silent !echo -e "'.args.'"'
        execute cmd
        redraw!
    endif
endfunction
autocmd BufEnter * call SetTerminalTitle()

" Remaps
let mapleader=" "
nnoremap <leader><CR> :so ~/.vimrc<CR>


let g:netrw_liststyle=3     " tree view

" Enable "Hardmode" to learn h,j,k,l
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nnoremap <leader>pv :Vex!<CR>

" Make Y work like D and C
nnoremap Y yg_

" Keep cursor position when bouncing around
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z

" Sets better undo points during insert mode
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Allow moving of blocks of lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> :m .+1<CR>==
inoremap <C-k> :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
