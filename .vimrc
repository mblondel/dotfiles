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

" File completion
set wildmode=longest,list,full
"set wildmenu

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

" Search
set nohlsearch
nmap <silent> <leader>h :set hlsearch!<CR>

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
colorscheme jellybeans

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
autocmd BufWritePre *.py,*.pyx,*.pxd,*.rb,*.c,*.cc,*.cpp,*.h,*.rst  :call <SID>StripTrailingWhitespaces()
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

