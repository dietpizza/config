" plugins
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'mhinz/vim-sayonara'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'alvan/vim-closetag'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'mhinz/vim-startify'
call plug#end()

" defaults
syntax enable
set smarttab
set autoread
set cursorline
set cindent
set tabstop=2
set shiftwidth=2
set expandtab
set number
" set fcs=eob:\ 
" set completeopt-=preview
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=no
set termguicolors
set foldcolumn=0
set showtabline=2
set noshowmode
set iskeyword+=-

" Autoread changes
if ! exists("g:CheckUpdateStarted")
    let g:CheckUpdateStarted=1
    call timer_start(1,'CheckUpdate')
endif
function! CheckUpdate(timer)
    silent! checktime
    call timer_start(1000,'CheckUpdate')
endfunction

" mappings
nmap <silent> <C-f>     :CocCommand explorer --toggle<CR>
nmap <silent> <A-r>     :CocCommand flutter.run<CR>
nmap <silent> <C-o>     :Rg<CR>
nmap <silent> <C-p>     :ProjectFiles<CR>
nmap <silent> <C-l>     :BLines<CR>
nmap <silent> <A-CR>    :CocCommand actions.open<CR>
nmap <silent> <A-Right> :bnext<CR>
nmap <silent> <A-Left>  :bprev<CR>

vmap <C-_> <plug>NERDCommenterToggle
nmap <C-_> <plug>NERDCommenterToggle

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <F2> <Plug>(coc-rename)
inoremap <silent><expr> <C-Space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nnoremap <silent> K :call <SID>show_documentation()<CR>

tnoremap `` <c-\><c-n>

" colorscheme
let g:solarized_termtrans = 1
let g:solarized_term_italics = 0
let g:solarized_old_cursor_style = 1
colorscheme solarized8

" relative colors
hi Normal guibg=none
hi LineNr guibg=none
hi VertSplit guibg=none

" custom colors
hi Search guifg=#839496
hi EndOfBuffer guifg=#073642

" autocommands
autocmd Filetype coc-explorer,startify,floaterm,vim,fzf :IndentLinesDisable
autocmd FileType startify set cursorline
autocmd FileType floaterm set nonumber

" Makefiles only
autocmd FileType make set noexpandtab

" vim-floaterm
let g:floaterm_keymap_new    = '<F24>'
let g:floaterm_keymap_prev   = '<A-h>'
let g:floaterm_keymap_next   = '<A-l>'
let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_width         = 0.9
let g:floaterm_height        = 0.9
let g:floaterm_rootmarkers   = ['.git', '.gitignore', 'node_modules', 'package.json']

" sayonara
:cnoreabbrev wq w<bar>Sayonara
:cnoreabbrev W w
:cnoreabbrev q Sayonara

" lightline.vim
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'left': [ ['mode', 'paste'], ['filename'] ],
  \   'right': [ ['lineinfo'], ['percent'], ['fileencoding', 'filetype'] ],
  \ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' },
  \ 'tabline': {
  \   'left': [ ['buffers'] ],
  \   'right': [ ['placeholder'] ]
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers'
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel'
  \ },
  \ 'component': {
  \   'placeholder': 'buffers'
  \ },
  \ }
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#modified = ' *'
let g:lightline#bufferline#filename_modifier = ':t'

" indentLine
let g:indentLine_char = '¦'

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

" coc.nvim
let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-actions',
  \ 'coc-explorer',
  \ 'coc-snippets',
  \ 'coc-prettier',
  \ 'coc-flutter-tools',
  \ 'coc-vimlsp',
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-css',
  \ 'coc-tailwindcss',
  \ 'coc-clangd',
  \ ]

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" run tailwindCSS sort classes on save
" autocmd FileType javascript,javascriptreact,typescript,typescriptreact,html,vue autocmd BufWritePre * :CocCommand tailwindCSS.headwind.sortTailwindClasses

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" startify
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_lists = [
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': 'files',     'header': ['   Recent Files']   },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ ]
let g:startify_bookmarks = [
  \ { 'i': '~/.config/nvim/init.vim'},
  \ { 'z': '~/.zshrc'},
  \ { 'b': '~/.config/.bin'},
  \ { 'a': '~/.config/alacritty/alacritty.yml'},
  \ ]
let g:startify_change_to_vcs_root = 1

" fzf.vim
let FZF_DEFAULT_OPTS = '--inline-info --layout=reverse'
let FZF_DEFAULT_COMMAND = 'rg --files --hidden --ignore-case'

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()
let g:fzf_layout = {
  \ 'up':'~90%',
  \ 'window': {
  \ 'width': 0.9, 'height': 0.9,
  \ 'yoffset':0.5,
  \ 'xoffset': 0.5,
  \ 'border': 'sharp' 
  \ } 
  \ }
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] 
  \ }

command! -bang -nargs=* Rg
  \ call fzf#vim#grep (
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \ )

" vim-closetag
let g:closetag_shortcut = '>'
let g:closetag_filenames = "*.html,*.xhtml,*.js,*.jsx"
