" Add default colorscheme here so we can override later.
syntax enable
set re=0
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

if exists('g:loaded_minpac')
  "minpac is available.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  command! PackUpdate call minpac#update()
  command! PackClean call minpac#clean()

  " Update colorscheme to use plugin
  " call minpac#add('crusoexia/vim-monokai')
  call minpac#add('gruvbox-community/gruvbox')
  colorscheme gruvbox

  " Statusline
  call minpac#add('itchyny/lightline.vim')

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
  " let g:ale_javascript_eslint_use_global = 1
  " let g:ale_linters_explicit = 1
  " let g:ale_sign_column_always = 1
  " " let g:ale_sign_error = '>>'
  " " let g:ale_sign_warning = '--'
  " let g:ale_sign_error = '❌'
  " let g:ale_sign_warning = '⚠️'
  " let g:ale_fix_on_save = 1

  call minpac#add('neoclide/coc.nvim', {"branch": "release"})
  let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-pairs'
    \ ]

  if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
    let g:coc_global_extensions += ['coc-prettier']
  endif

  if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
    let g:coc_global_extensions += ['coc-eslint']
  endif

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " NOTE: There's always complete item selected by default, you may want to enable
  " no select by `"suggest.noselect": true` in your configuration file.
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice.
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call ShowDocumentation()<CR>

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Javascript highlighting
  call minpac#add('sheerun/vim-polyglot')

  " NerdCommenter
  call minpac#add('scrooloose/nerdcommenter')
  let g:NERDSpaceDelims = 1
  let g:NERDDefaultAlign = 'left'

  call minpac#add('tpope/vim-surround')
  " call minpac#add('jiangmiao/auto-pairs')

  " Emmet
  call minpac#add('mattn/emmet-vim')
  " imap <expr> <tab> emmet#expandAbbrIntelligent("\<C-e>")

  " Respect .editorconfig files. (http://editorconfig.org/)
  call minpac#add('editorconfig/editorconfig-vim')


  " TODO: Should the above be in a seperate "install" script?
endif

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
" hide default mode status and show lightline plugin
set noshowmode
set laststatus=2

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

" In Git commit messages, let’s make it 72 characters
autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn=+1
" In Git commit messages, also colour the 51st column (for titles)
autocmd FileType gitcommit set colorcolumn+=51

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

" Make `jj` switch to normal mode (for touchbar ease)
inoremap jj <esc>

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

" copy to the MacOS clipboard
nnoremap <leader>Y "*yy
vnoremap <leader>y "*y
