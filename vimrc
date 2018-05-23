set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'mileszs/ack.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'octol/vim-cpp-enhanced-highlight'
call vundle#end()
filetype plugin indent on

autocmd vimenter * NERDTree
map <F1> :NERDTreeToggle<CR> 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

syntax enable
set background=dark
colorscheme twilight256 
set backspace=indent,eol,start

filetype indent on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

autocmd Filetype python setlocal tabstop=4
autocmd Filetype python setlocal softtabstop=4
autocmd Filetype python setlocal shiftwidth=4


function! Formatonsave()
  let l:formatdiff = 1
  py3f /usr/share/clang/clang-format-3.8/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()

set colorcolumn=80

set ruler
set nu

nnoremap <C-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_global_ycm_extra_conf = '/home/wei/Documents/infra/src/.ycm_extra_conf.py'

set splitright


let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" auto close open brances/quoted
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction

nmap <F2> :call GotoJump()<CR>
set laststatus=2

autocmd BufWritePre *.py :%s/\s\+$//e
set paste
