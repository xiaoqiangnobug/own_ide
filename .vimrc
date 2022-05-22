set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
" 自定义插件安装 "
" 规范化折叠代码 "
Plugin 'tmhedberg/SimpylFold'
" 自动缩进规范化插件 "
Plugin 'vim-scripts/indentpython.vim'
" 代码自动提示插件 "
Bundle 'Valloric/YouCompleteMe'
" 语法高亮插件 "
Plugin 'scrooloose/syntastic'
" PEP8代码风格检查 "
Plugin 'nvie/vim-flake8'
" 树形文件结构插件 "
Plugin 'scrooloose/nerdtree'
" 配色方案插件 "
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
" 树形结构tab快捷键使用 "
Plugin 'jistr/vim-nerdtree-tabs'
" 文件搜索插件 "
Plugin 'kien/ctrlp.vim'
" git命令集成插件 "
Plugin 'tpope/vim-fugitive'
" 状态栏插件 "
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}


" 代码缩进设置 "
set foldmethod=indent
set foldlevel=99
" 设置空格快速折叠"
nnoremap <space> za

" 开启行号 "
set nu

" Python文件PEP8规范格式设置 "
au BufNewFile,BufRead *.py
\set tabstop=4
\set softtabstop=4
\set shiftwidth=4
\set textwidth=79
\set expandtab
\set autoindent
\set fileformat=unix

" 空白标红设置 -容易检查多余的空白"
hi BadWhitespace guifg=gray guibg=red ctermfg=gray ctermbg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" 设置文件编码格式 "
set encoding=utf-8

" 指定分割布局 "
"set splitbelow"
"set splitright"

" 快捷键切换分割布局 "
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 代码补全插件优化设置 "
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{1}'],
			\ 'cs,lua,javascript': ['re!\w{1}'],
			\ }

" 代码自动补全插件和vim识别虚拟环境 "
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" flake8 优化设置 "
let python_highlight_all=1
syntax on

" 自动检测使用配色方案 "
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

" 隐藏.pyc文件 "
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"使用系统粘贴板 "
set clipboard=unnamed

" F5快捷运行 "
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'cpp'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'java'
                exec "!javac %"
                exec "!time java %<"
        elseif &filetype == 'sh'
                :!time bash %
        elseif &filetype == 'python'
                exec "!clear"
                exec "!time python3 %"
        elseif &filetype == 'html'
                exec "!firefox % &"
        elseif &filetype == 'go'
                " exec "!go build %<"
                exec "!time go run %"
        elseif &filetype == 'mkd'
                exec "!~/.vim/markdown.pl % > %.html &"
                exec "!firefox %.html &"
        endif
endfunc

" 设置终端颜色以显示状态栏信息 "
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256

" 快捷打开文件树 "
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>

" 不显示隐藏文件
let g:NERDTreeHidden=0
" 过滤: 所有指定文件和文件夹不显示
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

" 自动添加文件头信息 "
func SetTitle()
	if &filetype == 'python'
		call setline(1, "#  coding=utf8")
		call setline(2, "")
		call setline(3, "\"\"\"")
		call setline(4, "==================================================")
		call setline(5, "")
		call setline(6, "  File Name: ".expand("%"))
		call setline(7, "")
		call setline(8, "  Author: xiaoqiang")
		call setline(9, "")
		call setline(10, "  Create Time: ".strftime("%c"))
		call setline(11, "")
		call setline(12, "  Last Modified: ".strftime("%c"))
		call setline(13, "")
		call setline(14, "  Description: ")
		call setline(15, "")
		call setline(16, "=================================================")
		call setline(17, "")
		call setline(18, "\"\"\"")
	endif
endfunc

" 自动创建文件头信息 "
autocmd BufNewFile *.py :call SetTitle()

" 自动添加最后修改时间函数 "
func SetLastTime()
	let line_str = getline(12)
	if line_str =~ "^  Last Modified:*"
		call setline(12, "  Last Modified: ".strftime("%c"))
	endif

endfunc

" 自动修改最后修改时间 "
autocmd BufWrite *.py :call SetLastTime()
