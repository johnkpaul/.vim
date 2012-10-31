silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

set wildignore=*/gen/*,*/node_modules/*
set background=light
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
set expandtab
set smartcase
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set syntax=automatic

set backspace=indent,eol,start " make backspace a more flexible
set backupdir=~/.vim/backup " where to put backup files
set directory=~/.vim/tmp

set incsearch " BUT do highlight as you type you
               " search phrase
set laststatus=2 " always show the status line
if has("mac")
  silent! set nomacatsui
else
  set lazyredraw
end
set linespace=2 " don't insert any extra pixel lines betweens rows
set list " show tabs and trailing spaces
set listchars=tab:>- " show tabs
set scrolloff=3 " Keep 4 lines (top/bottom) for scope
set ruler
set splitbelow
set splitright

set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%{exists('*rails#statusline')?rails#statusline():''}%{exists('*fugitive#statusline')?fugitive#statusline():''}%#ErrorMsg#%{exists('*SyntasticStatuslineFlag')?SyntasticStatuslineFlag():''}%*%=%-16(\ %l,%c-%v\ %)%P

set tags+=../tags,../../tags,../../../tags,../../../../tags,tmp/tags
set visualbell
set nu " line numbers
set grepprg=ack " FTW

" Autocommands

augroup RUBY
  autocmd!
  autocmd BufNewFile,BufRead */spec/**/*.rb,*_spec.rb compiler rspec " set the rspec compiler
  autocmd BufNewFile,BufRead */test/**/*.rb,*_test.rb compiler rubyunit " set the test unit compiler
  autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete " use rubycomplete
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  " autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby       set fdm=syntax fdl=99 " fold based on syntax, default fully open
  autocmd FileType ruby       set tabstop=2 shiftwidth=2 softtabstop=2
augroup END

" Plugins

let Tlist_Use_Right_Window=1
nnoremap <silent> <F8> :TlistToggle<CR>

let g:SuperTabDefaultCompletionType = "context"
" let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1

let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

let NERDSpaceDelims = 1

" Maps

let mapleader = ","

map <silent> <Leader>r :!ctags --extra=+f -R *<CR><CR>
map <Leader>s :Rake<CR>
map <Leader>c :.Rake<CR>
map <Leader>, <plug>NERDCommenterToggle

nmap <Leader>e :e **/
cmap <Leader>e **/

nmap <Leader>n :if &nu <bar> set nonu rnu <bar> else <bar> set nu nornu <bar> endif<CR>

augroup MARKDOWN
  autocmd!
  autocmd FileType markdown,man map <Leader>p :w<CR>:!markdown < % > %.html && open %.html<CR><CR>
  autocmd FileType markdown,man map <Leader>h1 :.g/.\+/copy. <Bar> s/./=/g <CR>
  autocmd FileType markdown,man map <Leader>h2 :.g/.\+/copy. <Bar> s/./-/g <CR>
augroup END

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Highlight filetype
" Using highlight library
command! -range=% Highlight exec "w !highlight -S " . &ft . " -R | pbcopy"

" Map escape key to jj
imap jj <esc>
" Map jj<enter> to <esc>:w<CR>
imap jj<CR> <esc>:w<CR>

 fun! SetupVAM()
          " YES, you can customize this vam_install_path path and everything still works!
          let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
          exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

          " * unix based os users may want to use this code checking out VAM
          " * windows users want to use http://mawercer.de/~marc/vam/index.php
          " to fetch VAM, VAM-known-repositories and the listed plugins
          " without having to install curl, unzip, git tool chain first
          " -> BUG [4] (git-less installation)
          if !filereadable(vam_install_path.'/vim-addon-manager/.git/config') && 1 == confirm("git clone VAM into ".vam_install_path."?","&Y\n&N")
            " I'm sorry having to add this reminder. Eventually it'll pay off.
            call confirm("Remind yourself that most plugins ship with documentation (README*, doc/*.txt). Its your first source of knowledge. If you can't find the info you're looking for in reasonable time ask maintainers to improve documentation")
            exec '!p='.shellescape(vam_install_path).'; mkdir -p "$p" && cd "$p" && git clone --depth 1 git://github.com/MarcWeber/vim-addon-manager.git'
            " VAM run helptags automatically if you install or update plugins
            exec 'helptags '.fnameescape(vam_install_path.'/vim-addon-manager/doc')
          endif

          " Example drop git sources unless git is in PATH. Same plugins can
          " be installed form www.vim.org. Lookup MergeSources to get more control
          " let g:vim_addon_manager['drop_git_sources'] = !executable('git')

          call vam#ActivateAddons([], {'auto_install' : 0})
          " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
          " - look up source from pool (<c-x><c-p> complete plugin names):
          " ActivateAddons(["foo", ..
          " - name rewritings:
          " ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
          " ..ActivateAddons(["github:user/repo", .. => github://user/repo
          " Also see section "2.2. names of addons and addon sources" in VAM's documentation
        endfun
        call SetupVAM()


set tags=~/customtags
let g:NERDTreeDirArrows=0
