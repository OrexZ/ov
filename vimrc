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

set wildmode    =longest,list

" no loop for search.
set nowrapscan

" AUTO change workspace: https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
" set autochdir
autocmd BufEnter * silent! lcd %:p:h

" set list                 " Show non-printable characters.
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
set directory   =$HOME/.vim/files/swap/
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo/
set viminfo     ='100,n$HOME/.vim/files/info/viminfo

" refer to: https://blog.csdn.net/diy534/article/details/7327213
set fencs =utf-8,gbk
" set guifont=Arial_monospaced_for_SAP:h9:cANSI
" set gfw=幼圆:h10:cGB2312


" Note that --sync flag is used to block the execution until the installer finishes.
" (If you're behind an HTTP proxy, you may need to add --insecure option to the curl command.
" In that case, you also need to set $GIT_SSL_NO_VERIFY to true.)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" <Leader Map>
let mapleader=","
noremap \ ,

" Mapped as Emacs in insert mode.
inoremap <C-A> <Home>
inoremap <C-B> <Left>
inoremap <C-E> <End>
inoremap <C-F> <Right>

" Exchange Windows
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k

" Rename file.
command! -nargs=1 Rename let tpname = expand('%:t') | saveas <args> | edit <args> | call delete(expand(tpname))

" Jump to your vimrc file in anytime.
command! -nargs=0 Ov edit $MYVIMRC

nnoremap <silent> <C-l>    :<C-u>nohlsearch<CR><C-l>
nnoremap <silent> <c-\>    <c-^>

command! W w !sudo tee % > /dev/null

" === [Special Plugged Configuration] <BEG>
"
call plug#begin('$HOME/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/SrcExpl'

Plug 'vim-scripts/Mark'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'

Plug 'kien/ctrlp.vim'
Plug 'skywind3000/vim-preview'
Plug 'MattesGroeger/vim-bookmarks'

Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'alok/notational-fzf-vim'

Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'

Plug 'guns/xterm-color-table.vim'

" NOTE> *Some useful plugins, but not persent.
" Plug 'vim-scripts/peaksea'
" Plug 't9md/vim-choosewin'
" Plug 'tpope/vim-fugitive'
" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'
" Plug 'yggdroot/indentline'
" Plug 'brookhong/cscope.vim'
" Plug 'hari-rangarajan/CCTree'
" Plug 'jdevera/vim-opengrok-search'

call plug#end()

if !isdirectory($HOME.'/VimNote') && exists('*mkdir') | call mkdir($HOME.'/VimNote') | endif
let g:nv_search_paths = [$HOME.'/VimNote']

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

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
nnoremap <silent> <leader>j       :Files<CR>
nnoremap <silent> <leader>f       :GFiles<CR>
nnoremap <silent> <leader>d       :Buffers<CR>

" TagList
nmap <F8> :TlistToggle<CR>
" Bug Fixed for TagList.vim, only support 'exuberant ctags'.
" The official website: http://ctags.sourceforge.net/
let Tlist_Ctags_Cmd = $CTAGS_BIN
let Tlist_Inc_Winwidth = 0
let Tlist_Exit_OnlyWindow = 0

let Tlist_Auto_Open = 0
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1

" <Gutentags>
" ALT> let g:gutentags_modules = ['ctags']
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" NOTE: close the default configuration
let g:gutentags_add_default_project_roots = 0

let g:gutentags_project_root = ['.bro']
let g:gutentags_ctags_tagfile = '.tags'

let s:vim_tags = expand('~/.cache/tags')
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
let g:gutentags_cache_dir = s:vim_tags

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

let g:gutentags_plus_switch = 1

" FIX: ERROR: gutentags: gtags-cscope job failed, returned: 1
" 1. :GutentagsToggleTrace
" 2. :GutentagsUpdate
let g:gutentags_define_advanced_commands = 1

" forbid gutentags adding gtags databases
let g:gutentags_auto_add_gtags_cscope = 1

let g:gutentags_plus_nomap = 1

noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>

" Source Explorer
" nmap <F6> :SrcExplToggle<CR>
" let g:SrcExpl_winHeight = 8
" let g:SrcExpl_refreshTime = 10
" let g:SrcExpl_jumpKey = "<ENTER>"
" let g:SrcExpl_gobackKey = "<SPACE>"
" let g:SrcExpl_searchLocalDef = 1
" let g:SrcExpl_isUpdateTags = 0
" let g:SrcExpl_prevDefKey = "<F3>"
" let g:SrcExpl_nextDefKey = "<F4>"
" let g:SrcExpl_nestedAutoCmd = 1
" let g:SrcExpl_pluginList = [
"         \ "__Tag_List__",
"         \ "_NERD_tree_",
"         \ "Source_Explorer"
"         \ ]

" NERD Tree
nmap <F5> :NERDTreeToggle<CR>
let NERDTreeWinPos = "left"
" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" <Beautiful theme>
if ! has("gui_running")
    set t_Co=256
endif

" feel free to choose :set background=light for a different style
" set background=dark
" colors peaksea

" [alt] > lucario
set number
colorscheme lucario

" ligth line
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" VIM Preview, tips
" 1> ctags --fields=+nS
" 2> close preview > CTRL+W z
noremap <F2> :PreviewTag<CR>

noremap <m-u> :PreviewScroll -1<cr>
noremap <m-d> :PreviewScroll +1<cr>
inoremap <m-u> <c-\><c-o>:PreviewScroll -1<cr>
inoremap <m-d> <c-\><c-o>:PreviewScroll +1<cr>

autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

noremap <F4> :PreviewSignature!<cr>
inoremap <F4> <c-\><c-o>:PreviewSignature!<cr>

" NerdTee show the Arrow type (common type for all terminal)
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" useful for switch windows
nmap  L  <Plug>(choosewin)

" BookMark
let g:bookmark_sign = '>>'
let g:bookmark_annotation_sign = '##'
let g:bookmark_save_per_working_dir = 0
let g:bookmark_auto_close = 0
let g:bookmark_auto_save_file = $HOME .'/.vim-bookmarks'
let g:bookmark_show_warning = 1
let g:bookmark_highlight_lines = 0
let g:bookmark_center = 1
let g:bookmark_location_list = 1

" === [Special Plugged Configuration] <END>

" show the tail space!
highlight YouExtraWhitespace ctermbg=red guibg=red
match YouExtraWhitespace /\s\+$/
" NOTE> insert mode not show !!!
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()


