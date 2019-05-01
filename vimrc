" vim: sw=2 sts=-1 et

set nocompatible
let s:is_win = has('win16') || has('win32') || has('win64')

" Windows-Unix compatibility
source $VIMRUNTIME/mswin.vim
behave xterm
silent! unmap <C-F>
silent! unmap <C-H>
silent! unmap! <C-F>
silent! unmap! <C-H>
unmap <C-Y>
if s:is_win
  set runtimepath^=~/.vim
else
  nunmap <C-Z>
endif

call plug#begin('~/.vim/plugged')

" Not so sensible ;-)
set encoding=utf-8
set scrolloff=5
set viminfo=
Plug 'tpope/vim-sensible'
set display=uhex

" More basic settings
let c_comment_strings = 1
let c_gnu = 1
let mapleader = ','
set cinoptions=:0g0N-s(0
set conceallevel=2
set cursorline
set exrc
set fileencodings=ucs-bom,utf-8,cp949,latin1
set hlsearch
set ignorecase smartcase
set linebreak
set mouse=a
set nobackup noundofile
set nofoldenable
set number
set regexpengine=1
set shortmess+=a
set showcmd
set splitbelow
set splitright
set sw=4 sts=-1 et
set title
set updatetime=100
if exists('&belloff')
  set belloff=all
endif
inoremap <C-U> <C-G>u<C-U>
map Y y$
augroup vimrc
  autocmd!
  autocmd FileType help,vim          setl keywordprg=:help
  autocmd FileType markdown,tex,text setl spell textwidth=80
augroup END
if s:is_win
  set clipboard=unnamed
  set columns=132 lines=43
  set directory=$TEMP
  set guifont=D2Coding:h10
  set guioptions=c
  set shell=cmd.exe
else
  set directory=/tmp
endif

" YouCompleteMe
if executable('cmake')
  if v:version > 704 || v:version == 704 && has('patch1578')
    if has('python') || has('python3')
      function! BuildYCM(info)
        if a:info.status != 'unchanged' || a:info.force
          if s:is_win
            silent !py install.py --clang-completer
          else
            execute 'silent !./install.py --clang-completer'
          endif
          redraw!
        endif
      endfunction
      Plug 'Valloric/YouCompleteMe', {'do': function('BuildYCM')}
    endif
  endif
endif
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_max_num_candidates = 10
let g:ycm_semantic_triggers = {
      \ 'c':            ['->', '.', 're![a-zA-Z_]+\w'],
      \ 'cpp,cuda':     ['->', '.', '::', 're![a-zA-Z_]+\w'],
      \ 'cs,python,vb': ['.', 're![a-zA-Z_]+\w'],
      \ 'ruby,rust':    ['.', '::', 're![a-zA-Z_]+\w'],
      \ 'lua':          ['.', ':', 're![a-zA-Z_]+\w'],
      \ }
nnoremap <silent> <F7> :YcmRestartServer<CR>
augroup ycm
  autocmd FileType *            let g:ycm_auto_trigger = 0
  autocmd FileType c            let g:ycm_auto_trigger = 1
  autocmd FileType cpp,cuda     let g:ycm_auto_trigger = 1
  autocmd FileType cs,python,vb let g:ycm_auto_trigger = 1
  autocmd FileType ruby,rust    let g:ycm_auto_trigger = 1
  autocmd FileType lua          let g:ycm_auto_trigger = 1
augroup END
if !s:is_win
  Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}
endif

" UltiSnips
if has('python') || has('python3')
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  let g:UltiSnipsExpandTrigger = '<C-F>'
endif

" fzf
Plug 'junegunn/fzf', {
      \ 'dir': '~/.local/share/fzf',
      \ 'do': './install --all --no-bash --no-fish',
      \ }
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \ }
let g:fzf_layout = {'down': '~20%'}
augroup fzf
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 |
        \ autocmd BufLeave <buffer> set laststatus=2
augroup END
Plug 'junegunn/fzf.vim'
nnoremap <silent> <C-P> :Files<CR>
nnoremap <silent> <Leader>f :execute 'Ag ' . expand('<cword>')<CR>
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number '.shellescape(<q-args>), 0,
      \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
imap <C-X><C-F> <Plug>(fzf-complete-path)

" Search enhancement
Plug 'osyo-manga/vim-anzu'
set statusline=%{anzu#search_status()}
let g:anzu_status_format = ' %p (%i/%l) %#WarningMsg#%w'
let g:airline#extensions#anzu#enabled = 0
Plug 'haya14busa/incsearch.vim'
nmap /  <Plug>(incsearch-forward)
nmap ?  <Plug>(incsearch-backward)
nmap g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
nmap n  <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
nmap N  <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)
nmap *  <Plug>(incsearch-nohl)<Plug>(anzu-star-with-echo)
nmap #  <Plug>(incsearch-nohl)<Plug>(anzu-sharp-with-echo)
nmap g* <Plug>(incsearch-nohl-g*)<Plug>(anzu-update-search-status-with-echo)
nmap g# <Plug>(incsearch-nohl-g#)<Plug>(anzu-update-search-status-with-echo)
let g:incsearch#emacs_like_keymap = 1
Plug 'hauleth/sad.vim'

" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_exclude_preview = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'light'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.notexists = '*'
set linespace=0
set noshowmode
set ttimeoutlen=10

" Git support
Plug 'mhinz/vim-signify'
let g:signify_cursorhold_insert = 0
let g:signify_cursorhold_normal = 0
let g:signify_realtime = 1
let g:signify_update_on_bufenter = 0
let g:signify_vcs_list = ['git']
if exists('&signcolumn')
  set signcolumn=yes
endif
omap ac <plug>(signify-motion-outer-pending)
omap ic <plug>(signify-motion-inner-pending)
xmap ac <plug>(signify-motion-outer-visual)
xmap ic <plug>(signify-motion-inner-visual)
Plug 'tpope/vim-fugitive'

" Language support
let g:python_highlight_all = 0
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['markdown']
" Too much
let g:python_highlight_builtins = 0
let g:python_highlight_exceptions = 0
let g:python_highlight_operators = 0
let g:python_highlight_space_errors = 0
let g:python_highlight_file_headers_as_comments = 1
let g:vim_json_syntax_conceal = 1
augroup conceal
  " Set again
  autocmd FileType markdown setl conceallevel=2
  autocmd FileType tex      hi clear Conceal
augroup END
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key = '<C-G>'
Plug 'nvie/vim-flake8'
let g:flake8_quickfix_height = 7
Plug 'vim-scripts/python_match.vim'

" More plugins...
Plug 'Valloric/ListToggle'
Plug 'calebsmith/vim-lambdify'
Plug 'dkarter/bullets.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'nacitar/a.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sleuth'
Plug 'tweekmonster/startuptime.vim'
Plug 'yous/PreserveNoEOL'
Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1
Plug 'fidian/hexmode'
let g:hexmode_xxd_options = '-g 1 -u'
Plug 'junegunn/vim-easy-align'
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
Plug 'machakann/vim-highlightedyank'
if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
  vunmap <C-C>
  vunmap <C-Insert>
  vmap <C-C>      "+y
  vmap <C-Insert> "+y
endif
Plug 'machakann/vim-swap'
omap a, <Plug>(swap-textobject-a)
omap i, <Plug>(swap-textobject-i)
xmap a, <Plug>(swap-textobject-a)
xmap i, <Plug>(swap-textobject-i)
Plug 'simnalamburt/vim-mundo'
nnoremap <silent> <F2> :MundoToggle<CR>
Plug 'tmsvg/pear-tree'
let g:pear_tree_smart_backspace = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_openers = 1
Plug 'tpope/vim-commentary'
augroup commentary
  autocmd FileType c,cpp setl commentstring=//\ %s
augroup END
if v:version >= 800
  Plug 'johngrib/vim-game-code-break'
  Plug 'ludovicchabant/vim-gutentags'
else
  Plug 'ludovicchabant/vim-gutentags', {'branch': 'vim7'}
endif
if executable('ctags')
  Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
  nnoremap <silent> <F3> :TagbarToggle<CR>
endif

" Color scheme
Plug 'arcticicestudio/nord-vim'
let g:nord_italic = 0
Plug 'junegunn/limelight.vim'
nnoremap <silent> <F6> :Limelight!!<CR>
hi def link pythonClassVar Structure
if s:is_win
  let g:nord_comment_brightness = 20
else
  " Poor approximation
  let g:limelight_conceal_ctermfg = 102
  autocmd vimrc ColorScheme nord hi Comment ctermfg=102
endif

call plug#end()

silent! colorscheme nord
hi clear SpellBad
hi SpellBad cterm=underline gui=underline

set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
      \ | wincmd p | diffthis

" Hangul IME
if s:is_win
  augroup win_ime
    autocmd InsertEnter * :set noimdisable
    autocmd InsertLeave * :set imdisable
  augroup END
endif

inoremap <Up>    <Nop>
noremap  <Up>    <Nop>
inoremap <Down>  <Nop>
noremap  <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>
noremap  <Left>  <Nop>
noremap  <Right> <Nop>
" Ⓑ Ⓐ

" Some useful keymaps
nnoremap <F4>              :%s/\s\+$//e<CR><C-L>
nnoremap <Leader>1         :set sw=2<CR>
nnoremap <Leader>2         :set sw=4<CR>
nnoremap <Leader>3         :set sw=8<CR>
nnoremap <Leader><Leader>1 :set ts=2<CR>
nnoremap <Leader><Leader>2 :set ts=4<CR>
nnoremap <Leader><Leader>3 :set ts=8<CR>
nnoremap <Leader>a         :set paste<CR>i
nnoremap <Leader>d         :let &cc = 81 - &cc<CR>:set cc?<CR>
nnoremap <Leader>e         :set et! et?<CR>
nnoremap <Leader>s         :set list! list?<CR>
nnoremap <S-Tab>           <C-W>W
nnoremap <Tab>             <C-W>w
noremap  gV                `[v`]
autocmd vimrc InsertLeave * set nopaste

" Press F5 to run
augroup f5_run
  if s:is_win
    autocmd FileType c        nnoremap <Plug>(run)
          \ :silent !clang -o %:r.exe % & %:r & pause<CR>
    autocmd FileType cpp      nnoremap <Plug>(run)
          \ :silent !clang++ -o %:r.exe % & %:r & pause<CR>
    autocmd FileType dosbatch nnoremap <Plug>(run)
          \ :silent !% & pause<CR>
    autocmd FileType python   nnoremap <Plug>(run)
          \ :silent !py % & pause<CR>
    autocmd FileType c,cpp,dosbatch,python
          \ imap <silent> <F5> <C-O>:up<CR><C-O><Plug>(run)
    autocmd FileType c,cpp,dosbatch,python
          \ nmap <silent> <F5> :up<CR><Plug>(run)
  else
    autocmd FileType c,cpp     nnoremap <Plug>(run)
          \ :make %:r && ./%:r<CR>
    autocmd FileType python,sh nnoremap <Plug>(run)
          \ :!./%<CR>
    autocmd FileType c,cpp,python,sh
          \ imap <silent> <F5> <C-O>:up<CR><C-O><Plug>(run)
    autocmd FileType c,cpp,python,sh
          \ nmap <silent> <F5> :up<CR><Plug>(run)
  endif
augroup END
