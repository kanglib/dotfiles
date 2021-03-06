" vim: sw=2 sts=-1 et

set encoding=utf-8
if v:version < 800 || !has('python3')
  echoerr 'Vim 8 with Python 3 support required'
endif
source $VIMRUNTIME/defaults.vim

" Windows-Unix compatibility
let s:is_win = has('win16') || has('win32') || has('win64')
source $VIMRUNTIME/mswin.vim
behave xterm
silent! unmap <C-F>
silent! unmap <C-H>
silent! unmap <C-Y>
silent! unmap! <C-F>
silent! unmap! <C-H>
silent! unmap! <C-Y>
if s:is_win
  set runtimepath^=~/.vim
else
  silent! nunmap <C-Z>
endif

call plug#begin('~/.vim/plugged')

" Not so sensible ;-)
set viminfo=
Plug 'tpope/vim-sensible'
set display=uhex

" More basic settings
let c_gnu = 1
let mapleader = ','
set belloff=all
set cinoptions=:0g0N-s(0
set conceallevel=2
set cursorline
set fileencodings=ucs-bom,utf-8,cp949,latin1
set hlsearch
set ignorecase smartcase
set linebreak
set modeline
set mouse=a
set nofoldenable
set number
set regexpengine=1
set shortmess+=ac
set spelllang+=cjk
set splitright
set sw=4 sts=-1 et
set t_md=
set title
set updatetime=100
inoremap <C-U> <C-G>u<C-U>
map Y y$
augroup vimrc
  autocmd!
  autocmd FileType help,vim                   setl keywordprg=:help
  autocmd FileType markdown,plaintex,tex,text setl spell textwidth=80
augroup END
if s:is_win
  set columns=132 lines=43
  set directory=$TEMP
  set guifont=D2Coding:h10
  set guioptions=c
  set renderoptions=type:directx
  set shell=cmd.exe
else
  set directory=/tmp
endif

" Language Server Protocol
Plug 'prabirshrestha/vim-lsp'
function! s:on_lsp_buffer_enabled() abort
  let g:lsp_diagnostics_enabled = 0
  let g:lsp_fold_enabled = 0            " TODO
  let g:lsp_format_sync_timeout = 1000
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  inoremap <buffer> <expr><c-f> lsp#scroll(+4)
  inoremap <buffer> <expr><c-d> lsp#scroll(-4)
  autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
endfunction
augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
Plug 'mattn/vim-lsp-settings'
let g:lsp_settings_enable_suggestions = 0
let g:lsp_settings_servers_dir = '~/.vim/servers'
nnoremap <F7> :LspInstallServer<CR>

" asyncomplete
Plug 'prabirshrestha/asyncomplete.vim'
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
Plug 'prabirshrestha/asyncomplete-file.vim'
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
      \ 'name': 'file',
      \ 'allowlist': ['*'],
      \ 'completor': function('asyncomplete#sources#file#completor')
      \ }))
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-necovim.vim' | Plug 'Shougo/neco-vim'
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
      \ 'name': 'necovim',
      \ 'allowlist': ['vim'],
      \ 'completor': function('asyncomplete#sources#necovim#completor'),
      \ }))
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
      \ 'name': 'ultisnips',
      \ 'allowlist': ['*'],
      \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
      \ }))
Plug 'wellle/tmux-complete.vim' | Plug 'prabirshrestha/async.vim'
let g:tmuxcomplete#trigger = ''

" UltiSnips
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = '<C-E>'
let g:UltiSnipsRemoveSelectModeMappings = 0

" ALE
Plug 'dense-analysis/ale'
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)
" Without regexp
nnoremap <F4> :ALEFix<CR>
hi clear ALEErrorSign
hi clear ALEWarningSign

" Git support
Plug 'mhinz/vim-signify'
let g:signify_cursorhold_insert = 0
let g:signify_cursorhold_normal = 0
let g:signify_realtime = 1
let g:signify_update_on_bufenter = 0
let g:signify_vcs_list = ['git']
set signcolumn=yes
omap ac <plug>(signify-motion-outer-pending)
omap ic <plug>(signify-motion-inner-pending)
xmap ac <plug>(signify-motion-outer-visual)
xmap ic <plug>(signify-motion-inner-visual)
Plug 'tpope/vim-fugitive'

" Language support
let g:python_highlight_all = 0
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['lifelines', 'markdown']
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
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key = '<C-G>'
Plug 'kanglib/vim-loves-dafny', {'for': 'dafny'}
Plug 'vim-scripts/python_match.vim'

" Search enhancement
Plug 'hauleth/sad.vim'
if has('patch-8.0.1206')
  Plug 'markonm/traces.vim'
else
  Plug 'haya14busa/incsearch.vim'
  let g:incsearch#auto_nohlsearch = 1
  nmap #  <Plug>(incsearch-nohl-#)
  nmap *  <Plug>(incsearch-nohl-*)
  nmap /  <Plug>(incsearch-forward)
  nmap ?  <Plug>(incsearch-backward)
  nmap N  <Plug>(incsearch-nohl-N)
  nmap g# <Plug>(incsearch-nohl-g#)
  nmap g* <Plug>(incsearch-nohl-g*)
  nmap g/ <Plug>(incsearch-stay)
  nmap n  <Plug>(incsearch-nohl-n)
endif

" Tagging
if has('cscope') && executable('cscope')
  let s:db = findfile('cscope.out', '.;')
  if !empty(s:db)
    execute 'cscope add ' . s:db
  endif
  set cscopetag
  set cscopeverbose
  nmap <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\><C-\>a :vert scs find a <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\><C-\>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\><C-\>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\><C-\>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-\><C-\>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\><C-\>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-\><C-\>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
endif
if executable('ctags')
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
  if has('cscope') && !&cscopetag
    nmap <C-]> :exe 'tjump ' . expand('<cword>')<CR>
  endif
  nnoremap <silent> <F3> :TagbarToggle<CR>
endif

" fzf
if s:is_win
  " Don't update...
  Plug 'junegunn/fzf', {
        \ 'dir': '~/.local/share/fzf',
        \ }
else
  Plug 'junegunn/fzf', {
        \ 'dir': '~/.local/share/fzf',
        \ 'do': './install --all --no-bash --no-fish',
        \ }
endif
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
nnoremap <silent> <Leader>f :exe 'Rg ' . expand('<cword>')<CR>

" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_detect_iminsert = 1
let g:airline_detect_spelllang = 0
let g:airline_exclude_preview = 1
let g:airline_powerline_fonts = 1
let g:airline_symbols = {}
let g:airline_symbols.linenr = ''
let g:airline_symbols.notexists = '*'
let g:airline_symbols.whitespace = ''
let g:airline_theme = 'light'
set linespace=0
set noshowmode
set ttimeoutlen=10

" More plugins...
Plug 'Valloric/ListToggle'
Plug 'calebsmith/vim-lambdify'
Plug 'johngrib/vim-game-code-break'
Plug 'machakann/vim-highlightedyank'
Plug 'nacitar/a.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sleuth'
Plug 'wellle/context.vim'
Plug 'yous/PreserveNoEOL'
Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1
Plug 'dciccale/guizoom.vim'
nmap <silent> + :ZoomIn<CR>
nmap <silent> - :ZoomOut<CR>
nmap <silent> <Leader>= :ZoomReset<CR>
Plug 'fidian/hexmode'
let g:hexmode_xxd_options = '-g 1 -u'
Plug 'junegunn/limelight.vim'
nnoremap <silent> <F6> :Limelight!!<CR>
Plug 'junegunn/vim-easy-align'
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
Plug 'machakann/vim-swap'
omap a, <Plug>(swap-textobject-a)
omap i, <Plug>(swap-textobject-i)
xmap a, <Plug>(swap-textobject-a)
xmap i, <Plug>(swap-textobject-i)
Plug 'mbbill/undotree'
nnoremap <silent> <F2> :UndotreeToggle<CR>
Plug 'tmsvg/pear-tree'
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_backspace = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_openers = 1
Plug 'tpope/vim-commentary'
autocmd vimrc FileType c,cpp,cuda,dafny setl commentstring=//\ %s

" Color scheme
Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim'}

call plug#end()

silent! colorscheme Tomorrow-Night
let g:limelight_conceal_ctermfg = 'DarkGray'
" Workaround for microsoft/terminal#832
hi Normal ctermfg=NONE ctermbg=NONE
hi clear SpellBad
hi SpellBad cterm=underline gui=underline
hi link pythonClassVar Structure

set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*

" Hangul IME
if s:is_win
  augroup win_ime
    autocmd InsertEnter * :set noimdisable
    autocmd InsertLeave * :set imdisable
  augroup END
endif

" Some useful keymaps
nnoremap <Leader>1         :set sw=2<CR>
nnoremap <Leader>2         :set sw=4<CR>
nnoremap <Leader>3         :set sw=8<CR>
nnoremap <Leader><Leader>1 :set ts=2<CR>
nnoremap <Leader><Leader>2 :set ts=4<CR>
nnoremap <Leader><Leader>3 :set ts=8<CR>
nnoremap <Leader>a         :set paste<CR>i
nnoremap <Leader>c         :let &cc = 81 - &cc<CR>:set cc?<CR>
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
