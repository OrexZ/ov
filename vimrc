" _____                  __  __
"/\  __`\               /\ \/\ \  __
"\ \ \/\ \  __  __  _ __\ \ \ \ \/\_\    ___ ___
" \ \ \ \ \/\ \/\ \/\`'__\ \ \ \ \/\ \ /' __` __`\
"  \ \ \_\ \ \ \_\ \ \ \/ \ \ \_/ \ \ \/\ \/\ \/\ \
"   \ \_____\ \____/\ \_\  \ `\___/\ \_\ \_\ \_\ \_\
"    \/_____/\/___/  \/_/   `\/__/  \/_/\/_/\/_/\/_/
"
"=============================================================================
" Filetype: vimrc
" Copyright (c) 2019-2020 Rex Zheng & Contributors
" Author: Yang Zheng < darling.mz at 163.com >
" URL:
" License: MIT
"=============================================================================

set nocompatible|"Our VIM ^_^

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

"set autochdir              " Auto change workspace, maybe 'lcd' is better.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set completeopt =noselect,menu " Firstly, don't show the menu.
set noshowmode             " 'lightline' plugin is more useful.

" set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

if !has('gui_running')
  set t_Co=256
endif

" create directory if needed
if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')        | call mkdir($HOME.'/.vim/files') | endif
if !isdirectory($HOME.'/.vim/files/backup') && exists('*mkdir') | call mkdir($HOME.'/.vim/files/backup') | endif
if !isdirectory($HOME.'/.vim/files/undo') && exists('*mkdir')   | call mkdir($HOME.'/.vim/files/undo') | endif
if !isdirectory($HOME.'/.vim/files/info') && exists('*mkdir')   | call mkdir($HOME.'/.vim/files/info') | endif
if !isdirectory($HOME.'/.vim/files/swap') && exists('*mkdir')   | call mkdir($HOME.'/.vim/files/swap') | endif

" Put all temporary files under the same directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
set backup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap//
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo/
set viminfo     ='100,n$HOME/.vim/files/info/viminfo


" Note that --sync flag is used to block the execution until the installer finishes.
" (If you're behind an HTTP proxy, you may need to add --insecure option to the curl command.
" In that case, you also need to set $GIT_SSL_NO_VERIFY to true.)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" === [Special Plugged Configuration] <BEG>
"
call plug#begin('$HOME/.vim/plugged')

Plug 'vim-scripts/SrcExpl'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/taglist.vim'
" Plug 'wesleyche/trinity'

Plug 'itchyny/lightline.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/Alok/notational-fzf-vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

call plug#end()

if !isdirectory($HOME.'/MzNote') && exists('*mkdir') | call mkdir($HOME.'/note') | endif
let g:nv_search_paths = ['$HOME/MzNote']

" let g:gen_tags#gtags_default_map=1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" spec
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" === [Special Plugged Configuration] <END>

" Mapped as Emacs.
inoremap <C-A> <Home>
inoremap <C-B> <Left>
inoremap <C-E> <End>
inoremap <C-F> <Right>

nmap <C-J> <C-W>j
nmap <C-K> <C-W>k

" Rename file.
command! -nargs=1 Rename let tpname = expand('%:t') | saveas <args> | edit <args> | call delete(expand(tpname))

" Jump to your vimrc file in anytime.
command! -nargs=0 Ov edit $MYVIMRC

" Key-Board Maps
nnoremap <silent> <c-l>     :nohl<CR>
nnoremap <silent> <c-\>     <c-^>

command W w !sudo tee % > /dev/null

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" after fzf.vim
nnoremap <silent> <leader><space> :Commands<CR>
nnoremap <silent> <leader>a       :Rg<CR>
nnoremap <silent> <leader>s       :BLines<CR>
nnoremap <silent> <leader>f       :Files<CR>
nnoremap <silent> <leader>g       :GFiles<CR>
nnoremap <silent> <leader>d       :Buffers<CR>

" CsCope
set tags=$HOME/mz/mz-linux/new-lab/cloud-lab/labs/linux-lab/linux-stable/tags
set csprg=/usr/bin/cscope
set csto=0
set cst
set nocsverb

cs add $HOME/mz/mz-linux/new-lab/cloud-lab/labs/linux-lab/linux-stable/cscope.out $HOME/mz/mz-linux/new-lab/cloud-lab/labs/linux-lab/linux-stable
set csverb


" TagList
nmap <F5> :TlistToggle<CR>
" Bug Fixed for TagList.vim, only support 'exuberant ctags'.
" The official website: http://ctags.sourceforge.net/
let Tlist_Ctags_Cmd = '/usr/local/ctags-self/bin/ctags'
let Tlist_Inc_Winwidth = 0
let Tlist_Exit_OnlyWindow = 0

let Tlist_Auto_Open = 0
let Tlist_Use_Right_Window = 1

" Source Explorer
nmap <F6> :SrcExplToggle<CR>
let g:SrcExpl_winHeight = 8
let g:SrcExpl_refreshTime = 10
let g:SrcExpl_jumpKey = "<ENTER>"
let g:SrcExpl_gobackKey = "<SPACE>"
let g:SrcExpl_searchLocalDef = 1 
let g:SrcExpl_isUpdateTags = 0
let g:SrcExpl_prevDefKey = "<F3>"
let g:SrcExpl_nextDefKey = "<F4>"
let g:SrcExpl_nestedAutoCmd = 1
let g:SrcExpl_pluginList = [
        \ "__Tag_List__",
        \ "_NERD_tree_",
        \ "Source_Explorer"
        \ ]

" NERD Tree
nmap <F8> :NERDTreeToggle<CR>
let NERDTreeWinPos = "left"

