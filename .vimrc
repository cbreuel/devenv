set encoding=utf-8

" Non-Google version of .vimrc


" Configure status line
set laststatus=2
set statusline+=%f\ %l:%c

" Redefine the leader key
let mapleader = ","

" Move cursor by display (wrapped) lines instead of physical ones
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj

" Remap H and L to move 20 lines each
nnoremap H 20k
nnoremap L 20j

" Map ctrl-a to beginning of line
nnoremap <C-a> ^
vnoremap <C-a> ^

set nocompatible
filetype off

" External Plugins

" Init Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'jlanzarotta/bufexplorer'
" Redefine bufexplorer key sequence
nnoremap <leader>o :BufExplorer<cr>

Plugin 'google/vim-colorscheme-primary'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-glaive'
Plugin 'google/vim-codefmt'

Plugin 'ycm-core/YouCompleteMe'
Plugin 'Syntastic'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'einars/js-beautify'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'Shougo/vimproc.vim'          " Force install a dependency of tsuquyomi.
Plugin 'leafgarland/typescript-vim'  " enables TypeScript syntax-highlighting.
Plugin 'Quramy/tsuquyomi'            " enables TypeScript auto-completion.
Plugin 'vim-scripts/vim-auto-save'   " auto-save files after each edit

" Finish Vundle setup
call vundle#end()            " required

let g:codefmt_clang_format_style="{AllowShortFunctionsOnASingleLine: None, AllowShortBlocksOnASingleLine: false, AllowShortIfStatementsOnASingleLine: false, AllowShortLoopsOnASingleLine: false, SpacesInContainerLiterals: false}"
let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

filetype plugin indent on
syntax on

set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=100         " How many undos
set undoreload=1000        " number of lines to save for undo
set hlsearch
set incsearch
set ruler
set number
"set relativenumber

" AutoSave plugin options
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
if !exists("g:ycm_semantic_triggers")
   let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" Show trailing whitespace with a subtle but noticeable character
set list listchars=trail:␣
" Make splits open below and to the right (in "empty space") rather than above and to the left ("where we are now")
set splitbelow
set splitright
" Make tabs spaces, and all indents 2 spaces
set et ts=2 sts=2 sw=2
" Critical. Lets you switch buffers without saving the current one.
set hidden
" Hilight the 81st column
"set textwidth=80
"set colorcolumn=+1

"set t_Co=256
set background=dark
colorscheme primary
"colorscheme solarized

" make backspace work across lines
noremap <bs> X
set backspace=indent,eol,start
" respect <Del> at the end of line (only makes sense with virtualedit=onemore)
nnoremap <expr> <Del> (col('.') < col('$') ? '<Del>' : 'gJ')
inoremap <expr> <Del> (col('.') < col('$') ? '<Del>' : '<C-O>gJ')

" Remap paste in visual mode to replace selection
xnoremap p "_dP

" Set keys to copy to system clipboard
nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>

" Map key to replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Run Python files with F5
autocmd FileType python nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<cr>

" JSON Syntax Highlighting
" autocmd BufNewFile,BufRead *.json set ft=javascript
set nofoldenable    " disable folding

" Autocomplete menu colors
highlight Pmenu ctermfg=Black ctermbg=White
highlight PmenuSel ctermfg=Black ctermbg=Green


" Calling on yanked text: execute ":normal! i" . EscapeText(@")
function! EscapeText(text) range

    let l:escaped_text = a:text

    " Map characters to named C backslash escapes. Normally, single-quoted
    " strings don't require double-backslashing, but these are necessary
    " to make the substitute() call below work properly.
    "
    let l:charmap = {
    \   '"'     : '\\"',
    \   "'"     : '\\''',
    \   "\n"    : '\\n',
    \   "\r"    : '\\r',
    \   "\b"    : '\\b',
    \   "\t"    : '\\t',
    \   "\x07"  : '\\a',
    \   "\x0B"  : '\\v',
    \   "\f"    : '\\f',
    \   }

    " Escape any existing backslashes in the text first, before
    " generating new ones. (Vim dictionaries iterate in arbitrary order,
    " so this step can't be combined with the items() loop below.)
    "
    let l:escaped_text = substitute(l:escaped_text, "\\", '\\\', 'g')

    " Replace actual returns, newlines, tabs, etc., with their escaped
    " representations.
    "
    for [original, escaped] in items(charmap)
        let l:escaped_text = substitute(l:escaped_text, original, escaped, 'g')
    endfor

    " Replace any other character that isn't a letter, number,
    " punctuation, or space with a 3-digit octal escape sequence. (Octal
    " is used instead of hex, since octal escapes terminate after 3
    " digits. C allows hex escapes of any length, so it's possible for
    " them to run up against subsequent characters that might be valid
    " hex digits.)
    "
    let l:escaped_text = substitute(l:escaped_text,
    \   '\([^[:alnum:][:punct:] ]\)',
    \   '\="\\o" . printf("%03o",char2nr(submatch(1)))',
    \   'g')

    return l:escaped_text

endfunction

func! EscapeAndInsertText()

  execute ":normal! i" . EscapeText(@")

endfunction


" Indent Python in the Google way.

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"

