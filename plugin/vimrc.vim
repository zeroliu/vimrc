" Basic settings ----{{{
syntax on

scriptencoding utf-8
set encoding=utf-8
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
