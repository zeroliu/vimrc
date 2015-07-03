" Basic settings ----{{{
syntax on

set nocompatible
set t_Co=256
set history=1000
set background=dark

" Enable invisible characters
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Enable line numbers.
set number

" More natural splitting.
set splitbelow
set splitright

" Display Insert, Normal, Visual mode
set showmode

" Highlight current line
set cursorline

" Ignore case in search
set ignorecase
set smartcase

" Improve scroll jump when reaching the bottom
set scrolljump=5
set scrolloff=3

" Always display statusline
set laststatus=2

" Improve tab
set expandtab
set shiftwidth=2
set softtabstop=2

" Disable swap files.
set noswapfile

" Highlight searches.
set hlsearch

" Enable persistent undo.
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000

let mapleader=','

highlight clear SignColumn
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

colorscheme distinguished
highlight Folded ctermbg=237
" }}}

" FileType-specific settings ----{{{
filetype plugin indent on

augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileTYpe vim setlocal foldlevelstart=0
augroup END

augroup filetype_gitconfig
  autocmd!
  autocmd BufRead,BufNewFile *.gitconfig set filetype=gitconfig
augroup END

augroup filetype_tmux
  autocmd!
  autocmd BufRead,BufNewFile *.tmux.conf set filetype=tmux
augroup END
" }}}

" Plugins ----{{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Raimondi/delimitMate'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'kshenoy/vim-signature'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'airblade/vim-gitgutter'
Plugin 'mhinz/vim-startify'
Plugin 'hdima/python-syntax'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'vim-scripts/argtextobj.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'terryma/vim-expand-region'

call vundle#end()

source /usr/share/vim/google/google.vim
Glug git5
source /usr/share/vim/google/gtags.vim
" }}}

" Plugin Configs ----{{{
if isdirectory(expand("~/.vim/bundle/vim-expand-region"))
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
endif

if isdirectory(expand("~/.vim/bundle/YouCompleteMe"))
  let g:ycm_autoclose_preview_window_after_completion = 1
endif

if isdirectory(expand("~/.vim/bundle/vim-startify"))
  let g:startify_custom_header = [
          \ '      ___           ___           ___           ___',
          \ '     /  /\         /  /\         /  /\         /  /\',
          \ '    /  /::|       /  /:/_       /  /::\       /  /::\',
          \ '   /  /:/:|      /  /:/ /\     /  /:/\:\     /  /:/\:\',
          \ '  /  /:/|:|__   /  /:/ /:/_   /  /:/~/:/    /  /:/  \:\',
          \ ' /__/:/ |:| /\ /__/:/ /:/ /\ /__/:/ /:/___ /__/:/ \__\:\',
          \ ' \__\/  |:|/:/ \  \:\/:/ /:/ \  \:\/:::::/ \  \:\ /  /:/',
          \ '     |  |:/:/   \  \::/ /:/   \  \::/~~~~   \  \:\  /:/',
          \ '     |  |::/     \  \:\/:/     \  \:\        \  \:\/:/',
          \ '     |  |:/       \  \::/       \  \:\        \  \::/',
          \ '     |__|/         \__\/         \__\/         \__\/',
          \ '',
          \ '',
          \ ]
endif

if isdirectory(expand("~/.vim/bundle/nerdtree"))
  map <C-e> :NERDTreeToggle<CR>
  map <leader>e :NERDTreeFind<CR>
  nmap <leader>nt :NERDTreeFind<CR>

  let NERDTreeShowBookmark=1
  let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '\.svn$', '\.bzr$']
  let NERDTreeChDirMode=0
  let NERDTreeQuitOnOpen=1
  let NERDTreeShowHidden=1
endif

if isdirectory(expand("~/.vim/bundle/syntastic"))
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 1
  let g:syntastic_javascript_checkers = [ 'gjslint' ]
endif

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  nnoremap <leader>\ :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>
endif

if isdirectory(expand("~/.vim/bundle/ctrlp.vim"))
  " Use ag in CtrlP because it is faster
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " It is so fast that we don't even need cache
  let g:ctrlp_use_caching = 0
  let g:ctrlp_root_markers = ['.ctrlp']
endif

if isdirectory(expand("~/.vim/bundle/vim-snipmate"))
  imap <c-j> <esc>a<Plug>snipMateNextOrTrigger
  smap <c-j> <Plug>snipMateNextOrTrigger
endif

if isdirectory(expand("~/.vim/bundle/python-syntax"))
  let python_highlight_all = 1
endif

let g:airline#extensions#tabline#enabled = 1
" }}}

" General Mappings ----{{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>/ viwy/<c-r>"<cr>
nnoremap <leader>? viwy?<c-r>"<cr>
vnoremap // y/<c-r>"<cr>

inoremap jk <esc>
inoremap JK <esc>
inoremap <C-c> <CR><Esc>O
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l
noremap <C-h> <C-W>h
nnoremap j gj
nnoremap k gk
nnoremap K i<CR><Esc>
nnoremap <silent> <leader>d :bp\|bd #<CR>
nnoremap <C-]> :exe 'let searchtag= "' . expand('<cword>') . '"' \| :exe 'let @/= "' . searchtag . '"'<CR> \| :exe 'Gtag ' . searchtag <CR>

" Clear search highlighting.
nnoremap <esc><esc> :let @/=""<cr>

" Force to use hjkl.
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Buffer navigation.
nnoremap gp :bp<cr>
nnoremap gn :bn<cr>
nnoremap gl :ls<cr>:b

" Quick session bindings.
nnoremap <silent> <leader>sw :mksession! ~/.quicksave.vim<cr>
nnoremap <silent> <leader>sr :source ~/.quicksave.vim<cr>

" Move to begin and end of a fold
nnoremap z] zo]z
nnoremap z[ zo[z

" Make Cut, Copy and Paste to feel native
vnoremap <C-c> "*y
vnoremap <C-x> "*d
inoremap <C-v> <Esc>:set paste<CR>a<C-r>*<Esc>:set nopaste<CR>a
" }}}

" Key Fixes ----{{{
if has("user_commands")
  command! -bang -nargs=* -complete=file E e<bang> <args>
  command! -bang -nargs=* -complete=file W w<bang> <args>
  command! -bang -nargs=* -complete=file Wq wq<bang> <args>
  command! -bang -nargs=* -complete=file WQ wq<bang> <args>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
  command! -bang Q q<bang>
  command! -bang QA qa<bang>
  command! -bang Qa qa<bang>
endif
" }}}

" Folding ----{{{
augroup folding_python
  autocmd!
  autocmd FileType python setlocal foldmethod=expr
  autocmd FileTYpe python setlocal foldexpr=GetPythonFold(v:lnum)
augroup END

function! GetPythonFold(lnum)
  if getline(a:lnum) =~ '\vdef\s' || getline(a:lnum) =~ '\vclass\s' || getline(a:lnum) =~ '\v^\@'
    return '>' . IndentLevel(NextValidLine(a:lnum))
  endif

  if getline(a:lnum) =~ '\v^from'
    return '1'
  endif

  if getline(a:lnum) =~? '\v^\s*$'
    return '-1'
  endif

  if IndentLevel(a:lnum) > 2
    return 2
  endif

  return IndentLevel(a:lnum)
endfunction

augroup folding_javascript
  autocmd!
  autocmd FileType javascript setlocal foldmethod=expr
  autocmd FileTYpe javascript setlocal foldlevelstart=0
  autocmd FileTYpe javascript setlocal foldexpr=GetJavascriptFold(v:lnum)
augroup END

function! GetJavascriptFold(lnum)
  if IndentLevel(a:lnum) == 0
    if getline(a:lnum) =~ '\vfunction\('
      return '>1'
    endif

    if getline(a:lnum + 1) =~ '\vfunction\(' && IndentLevel(a:lnum) == IndentLevel(a:lnum + 1) - 2
      return '>1'
    endif

    if getline(a:lnum) =~ '\v\s\=\s\{$'
      return '>1'
    endif
  endif

  if getline(a:lnum) =~? '\v^\s*$'
    return '-1'
  endif

  if getline(a:lnum) =~? '\v^};$'
    return '1'
  endif

  if getline(a:lnum) =~? '\v^goog\.require\('
    return '1'
  endif

  if IndentLevel(a:lnum) > 0
    return '1'
  endif

  return '0'
endfunction

augroup folding_javascript_test
  autocmd!
  autocmd BufRead,BufNewFile *_test.js setlocal foldmethod=expr
  autocmd BufRead,BufNewFile *_test.js setlocal foldlevelstart=0
  autocmd BufRead,BufNewFile *_test.js setlocal foldexpr=GetJasmineFold(v:lnum)

augroup END

function! GetJasmineFold(lnum)
  if getline(a:lnum) =~? '\v^\s*$'
    return '-1'
  endif

  if getline(a:lnum) =~ '\v(it\(|describe\(|beforeEach\(|afterEach\()'
    return '>' . IndentLevel(NextValidLine(a:lnum))
  endif

  if getline(a:lnum) =~? '\v^};|}\);$'
    return '' . (IndentLevel(a:lnum) + 1)
  endif

  return IndentLevel(a:lnum)
endfunction

function! IndentLevel(lnum)
  return indent(a:lnum) / &shiftwidth
endfunction

function! NextValidLine(lnum)
  let numlines = line('$')
  let current = a:lnum + 1
  let initialIndent = IndentLevel(a:lnum)

  while current <= numlines
    if getline(current) =~? '\v\S$' && initialIndent == IndentLevel(current) - 1
      return current
    endif

    let current += 1
  endwhile

  return -2
endfunction
" }}}

" Custom Functions----{{{
" vp doesn't replace paste buffer
"function! RestoreRegister()
  "let @" = s:restore_reg
  "return ''
"endfunction
"function! s:Repl()
  "let s:restore_reg = @"
  "return "p@=RestoreRegister()<cr>"
"endfunction
"vmap <silent> <expr> p <sid>Repl()

" TODO: support multi spaces
" TODO: allow any formats: EX: var test = "aaa..."
function! WrapString()
  let s:line = line('.')
  let s:text = getline('.')
  let s:indent = indent(s:line)
  let s:output = ""

  " skip until the first '
  let s:count = 0
  for s:char in split(s:text, '\zs')
    if s:char == "'"
      break
    endif
    let s:count += 1
    let s:output .= s:char
  endfor
  let s:text = strpart(s:text, s:count)
  let s:text_list = split(s:text)

  for s:word in s:text_list
    " if end of the line
    if len(s:output) + len(s:word) + 1 > 76
      " wrap the line up by adding "' +"
      let s:output .= "' +"
      let s:failed = append(s:line, s:output)
      let s:line += 1

      " insert indentation for the next line
      let s:output = ""
      let s:index = -4
      while s:index < s:indent
        let s:output .= " "
        let s:index += 1
      endwhile

      " append the word to the beginning of the new line
      let s:output .= "'"
      let s:output .= s:word . " "
    else
      let s:output .= s:word . " "
    endif
  endfor

  " Don't forget the last line
  if s:output != ""
    let s:failed = append(s:line, strpart(s:output, 0, len(s:output) - 1))
  endif
endfunction

vnoremap <leader>r J:s/' + '//g<cr>:<c-u>call WrapString()<cr>dd
nnoremap <leader>r :<c-u>call WrapString()<cr>dd
" }}}

" Abbreviations ----{{{
iabbrev ytcomp yt.tv.components
iabbrev ytconst yt.tv.constants
" }}}
