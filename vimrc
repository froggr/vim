" Use Vim settings - in OSX with iTerm2
set nocompatible

" Pathogen!
call pathogen#infect()

" Syntastic settings
" Enable the status line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" Let the :Error window pop up automatically
let g:syntastic_auto_loc_list=1
let g:syntastic_auto_jump=1
let g:syntastic_mode_map={ 'mode': 'active','active_filetypes': [], 'passive_filetypes': ['html']  }


" Enable powerline symbols
" let g:Powerline_symbols = 'fancy'
" set encoding=utf-8
" set t_Co=256
set guifont=Inconsolatai-dz\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set term=xterm-256color
set termencoding=utf-8



" powerline in macvim
if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Inconsolata-dz\ for\ Powerline:h15
   endif
endif

" Turn on syntax highlighting, auto indent
syntax on
filetype plugin indent on

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" Move all backups to one directory
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set backspace=indent,eol,start

" Tab settings and autoindent
set tabstop=3
set shiftwidth=3
"set softtabstop=4
set noexpandtab
set autoindent

set laststatus=2
set showmatch
set incsearch

" Solarized slate
set background=dark
colorscheme slate

" Line numbers
set number

" Don't show scroll bars in the GUI
set guioptions-=L
set guioptions-=r

" Use tab for auto complete
function! SuperTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
endfunction
imap <Tab> <C-R>=SuperTab()<CR>

" Maps jj to <esc>
inoremap jj <esc>
map <c-f> :CtrlPClearAllCaches <enter>

" Laravel Blade Syntax
au BufRead,BufNewFile *.blade.php set filetype=html

command! W :w
let mapleader=","
nnoremap <Leader>t :! php artisan test <CR>

" resize horzontal split window   ^[[1;5A^[[1;5B^[[1;5C^[[1;5D]]]]]]]]
 map <ESC>[D <C-W>><C-W>>
map <ESC>[C <C-W><<C-W><
" resize vertical split window
 map <ESC>[A <C-W>+<C-W>+
 map <ESC>[B <C-W>-<C-W>-

set wildignore+=*vendor*

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>



com!  -nargs=* -bar -bang -complete=dir  Lexplore  call netrw#Lexplore(<q-args>, <bang>0)

fun! Lexplore(dir, right)
  if exists("t:netrw_lexbufnr")
  " close down netrw explorer window
  let lexwinnr = bufwinnr(t:netrw_lexbufnr)
  if lexwinnr != -1
    let curwin = winnr()
    exe lexwinnr."wincmd w"
    close
    exe curwin."wincmd w"
  endif
  unlet t:netrw_lexbufnr

  else
    " open netrw explorer window in the dir of current file
    " (even on remote files)
    let path = substitute(exists("b:netrw_curdir")? b:netrw_curdir : expand("%:p"), '^\(.*[/\\]\)[^/\\]*$','\1','e')
    exe (a:right? "botright" : "topleft")." vertical ".((g:netrw_winsize > 0)? (g:netrw_winsize*winwidth(0))/100 : -g:netrw_winsize) . " new"
    if a:dir != ""
      exe "Explore ".a:dir
    else
      exe "Explore ".path
    endif
    setlocal winfixwidth
    let t:netrw_lexbufnr = bufnr("%")
  endif
endfun

" absolute width of netrw window
let g:netrw_winsize = -28

" do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" use the previous window to open file
let g:netrw_browse_split = 4



