" 256-color terminal
set t_Co=256 

set encoding=utf-8 " screen
set fileencoding=utf-8 " file
set fileencodings=utf-8,euc-jp
set fileformat=unix
set fileformats=unix,dos,mac

let mapleader=','

" Highlight long lines
"match ErrorMsg '\%>80v.\+'

set number
set ruler

set wrap
" Symbol shown for linebreak
set showbreak=…

"set syntax=html
"set syntax=off
"
" Not compatible with vi
set nocompatible

" Use par program for gqip and gwip
:set formatprg=par\ -w75

" Enable spell checking by pressing ,s
nmap <silent> <leader>s :set spell!<CR>

set spelllang=en_us

set mouse=a

" Soft wrap
"set wrap " break long lines
"set linebreak " break words
"set nolist " nolist required

" Automatically set unchanged buffers to hidden
set hidden

" Visual bell only
"set visualbell

" Neither bell nor visual bell
autocmd VimEnter * set vb t_vb=

" Built-in file explorer
"let g:netrw_liststyle=3 " Use tree-mode as default view
let g:netrw_browse_split=4 " Open file in previous buffer
let g:netrw_preview=1 " preview window shown in a vertically split


" Use ,l to activate/desactivate list mode
nmap <leader>l :set list!<CR>
 
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

set list

colorscheme molokai

" expand tabs to 4 spaces by default
set ts=4 sts=4 sw=4 expandtab "noexpandtab 

" Enable file type detection
filetype on

filetype plugin indent on

" Set File type to 'text' for files ending in .txt
autocmd BufNewFile,BufRead *.txt setfiletype text
 
autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
autocmd FileType xml setlocal ts=2 sts=2 sw=2 expandtab
 
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab

autocmd FileType python setlocal textwidth=80 
autocmd FileType python let b:colors_name="molokai"
	
autocmd FileType tex setlocal textwidth=80 
autocmd FileType tex let b:colors_name="zellner"

" Soft wrap for text based
autocmd FileType text,markdown,html setlocal wrap linebreak nolist
 
" Treat .rss files as XML
autocmd BufNewFile,BufRead *.rss setfiletype xml

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction
 
function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

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

" Map command to F5
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" Trip trailing whitespace before save
autocmd BufWritePre *.py,*.rb,*.c,*.cpp,*.h  :call <SID>StripTrailingWhitespaces()

map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

"nmap <D-[> <<
"nmap <D-]> >>
"vmap <D-[> <gv
"vmap <D-]> >gv

" Replace C by D for Mac
map <C-S-]> gt
map <C-S-[> gT
map <C-1> 1gt
map <C-2> 2gt
map <C-3> 3gt
map <C-4> 4gt
map <C-5> 5gt
map <C-6> 6gt
map <C-7> 7gt
map <C-8> 8gt
map <C-9> 9gt
map <C-0> :tablast<CR>

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

" Add command Wrap
command! -nargs=* Wrap set wrap linebreak nolist


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

" Specify comment delimiter
au FileType haskell,ada let b:comment_leader = '-- '
au FileType vim let b:comment_leader = '" '
au FileType c,cpp,java let b:comment_leader = '// '
au FileType sh,make,python,ruby let b:comment_leader = '# '
au FileType tex let b:comment_leader = '% '

" Comment/Uncomment visual lines with ,c ,u
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

set whichwrap=b,s,h,l,<,>,[,]

" completion
set ofu=syntaxcomplete#Complete
