" Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Not compatible with vi
set nocompatible

" 256-color terminal
set t_Co=256

" Encoding
set encoding=utf-8 " screen
set fileencoding=utf-8 " file
set fileencodings=utf-8,euc-jp
set fileformat=unix
set fileformats=unix,dos,mac

" Temporary files
set nobackup
set noswapfile
set hidden

" Prefix for maps
let mapleader=','

" Visual
set number
set ruler
set cursorline
autocmd VimEnter * set vb t_vb= " neither bell nor visual bell

" Wrapping
set wrap
set showbreak=… " Symbol shown for linebreak
set backspace=indent,eol,start " Make backspace wrap lines
set whichwrap=b,s,h,l,<,>,[,]
"set wrap " break long lines
"set linebreak " break words
"set nolist " nolist required

" Don't yank when deleting stuff.
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" List mode
"" Use ,l to activate/desactivate list mode
nmap <leader>l :set list!<CR>
"" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
set list

" Formatting
"" Use par program for gqip and gwip
"" use gq to call par
"" use gw to call vim's formatter
"" use gwip to format current paragraph
:set formatprg=par\ -w75
:set formatoptions+=t

" Spell checking
"" Enable spell checking by pressing ,s
"" ]s to jump to next misspelling
"" z= to list spelling suggestions
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_us

" Mouse
set mouse=a

" Folding
"" zo: open current fold
"" zO: open current fold and subfolds
"" zR: open all folds
"" zc: close current fold
"" zC: close current fold and subfolds
"" zM: close all folds
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=2         "2 levels by default

" Shortcuts for opening files
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Color scheme
colorscheme molokai

" Spacing
set ts=4 sts=4 sw=4 expandtab "noexpandtab

" Syntax highlighting
syntax on

filetype on
filetype plugin indent on

autocmd BufNewFile,BufRead *.txt setfiletype text
autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
autocmd FileType xml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType text,markdown,html setlocal wrap linebreak nolist
autocmd BufNewFile,BufRead *.rss setfiletype xml

set ofu=syntaxcomplete#Complete

let python_highlight_all = 1

" Editing
"" Enter new line before/after without entering insert mode
map <S-Enter> O<Esc>
map <CR> o<Esc>

" NERDTree
"let g:netrw_liststyle=3 " Use tree-mode as default view
let g:netrw_browse_split=4 " Open file in previous buffer
let g:netrw_preview=1 " preview window shown in a vertically split
nnoremap <leader>n :NERDTreeToggle<CR>

" Function for striping trailing spaces
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" ,ss for trailing spaces
nnoremap <leader>ss :call <SID>StripTrailingWhitespaces()<CR>

" Automatically strip trailing whitespaces before save
autocmd BufWritePre *.py,*.pyx,*.rb,*.c,*.cc,*.cpp,*.h  :call <SID>StripTrailingWhitespaces()
"
" Highlight too long lines
function! HighlighTooLong()
    if &textwidth > 0
        if !exists('w:long_line_match')
            let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1)
        endif
    else
        if exists('w:long_line_match')
            silent! call matchdelete(w:long_line_match)
            unlet w:long_line_match
        endif
    endif
endfunction

" Highligh too long lines when entering buffer
autocmd BufEnter * :call HighlighTooLong()

" Highligh long lines by typing ,long
nnoremap <silent> <Leader>long
      \ :if exists('w:long_line_match') <Bar>
      \   silent! call matchdelete(w:long_line_match) <Bar>
      \   unlet w:long_line_match <Bar>
      \ elseif &textwidth > 0 <Bar>
      \   let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1) <Bar>
      \ else <Bar>
      \   let w:long_line_match = matchadd('ErrorMsg', '\%>80v.\+', -1) <Bar>
      \ endif<CR>


" Allow for buffers to have different colorschemes
" Variables used:
    " g:colors_name : current colorscheme at any moment
    " b:colors_name (if any): colorscheme to be used for the current buffer
    " s:colors_name : default colorscheme, to be used where b:colors_name hasn't been set
if has('user_commands')
    " User commands defined:
        " ColorScheme <name>
            " set the colorscheme for the current buffer
        " ColorDefault <name>
            " change the default colorscheme
    command -nargs=1 -bar ColorScheme
        \ colorscheme <args>
        \ | let b:colors_name = g:colors_name
    command -nargs=1 -bar ColorDefault
        \ let s:colors_name = <q-args>
        \ | if !exists('b:colors_name')
            \ | colors <args>
        \ | endif
endif
if !exists('g:colors_name')
    let g:colors_name = 'default'
endif
let s:colors_name = g:colors_name
au BufEnter *
    \ let s:new_colors = (exists('b:colors_name')?(b:colors_name):(s:colors_name))
    \ | if s:new_colors != g:colors_name
        \ | exe 'colors' s:new_colors
    \ | endif
