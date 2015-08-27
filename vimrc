" ALT+W 向上滚动一行
" ALT+S
" ALT+D
" ALT+E
" inputmode:
"   ALT+H
"   ALT+J
"   ALT+K
"   ALT+L
" windows change
"   ctrl+H
"   CTRL+J
"   CTRL+K
"   CTRL+L
" ZZ 当前行居中
" ZT 当前行置于顶部
" ZB
" F2 taglist
" F3 NERDTree
" F4 BufExplorer
" <leader> c  global copy
" <leader> v  global paste
" <leader> re rearrange
" [I          find word in all
" [S          find word in user input
" <leader> g  find word in all files under this floder
" <leader> rb
" <leader> rm
set path+=.
set tags=tags;
set autochdir
set nocompatible             " 关闭兼容模式
filetype off                  " required
set rtp+=$VIM/vimfiles/bundle/Vundle.vim
call vundle#begin('$VIM/vimfiles/bundle')
Bundle 'gmarik/Vundle.vim'
Bundle 'closetag.vim'
Bundle 'jiangmiao/auto-pairs'
Bundle 'vim-scripts/Rainbow-Parenthesis'
Bundle 'easymotion/vim-easymotion'
Bundle 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-fugitive'
Bundle 'ctrlp.vim'
map <silent><F9> :CtrlPClearCache<cr>

set wildignore+=*.so,*.pyc,*.zip,*.tar
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git)$',
  \ 'file': '\v\.(log|jpg|png|jpeg)$',
  \ }
Bundle 'vim-scripts/python-fold'
Bundle 'mattn/emmet-vim'
let g:indent_guides_enable_on_vim_startup = 0  " 默认关闭
let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level           = 2  " 从第二层开始可视化显示缩进
let g:indent_guides_color_change_percent = 80
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
map <leader>ig :IndentGuidesToggle<cr>
" ig 打开/关闭 vim-indent-guides
Bundle 'L9'
Bundle 'luochen1990/rainbow'
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
call vundle#end()            " required
filetype plugin indent on    " required


" 判断操作系统类型
if(has("win32") || has("win64"))
    let g:isWIN = 1
    let g:isMAC = 0
else
    if system("uname") =~ "Darwin"
        let g:isWIN = 0
        let g:isMAC = 1
    else
        let g:isWIN = 0
        let g:isMAC = 0
    endif
endif

" 判断是否处于GUI界面
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" handle the miss leading chinese.
let &termencoding=&encoding
" set fileencodings=utf-8
set encoding=utf-8
" 设置通用缩进策略
set shiftwidth=4

au BufWinLeave * silent mkview
au BufWinEnter * silent loadview

" 对部分语言设置单独的缩进
au FileType groovy,scala,clojure,scheme,racket,lisp,lua,ruby,eruby,slim,elixir,julia,dart,haxe,coffee,jade,sh set shiftwidth=2
au FileType groovy,scala,clojure,scheme,racket,lisp,lua,ruby,eruby,slim,elixir,julia,dart,haxe,coffee,jade,sh set tabstop=2


set foldenable     "允许折叠
set backspace=2              " 设置退格键可用
set autoindent               " 自动对齐
set ai!                      " 设置自动缩进
set smartindent              " 智能自动缩进
set smarttab
set nu
set nowrap
set mouse=a                  " 启用鼠标
set ruler                    " 右下角显示光标位置的状态行
set incsearch                " 开启实时搜索功能
set hlsearch                 " 开启高亮显示结果
set hidden                   " 允许在有未保存的修改时切换缓冲区
set autochdir                " 设定文件浏览器目录为当前目录
" set foldmethod=indent        " 选择代码折叠类型
set laststatus=2             " 开启状态栏信息
set cmdheight=2              " 命令行的高度，默认为1，这里设为2
" set foldlevel=100
set autoread                 " 当文件在外部被修改时自动更新该文件
set nobackup                 " 不生成备份文件
set noswapfile               " 不生成交换文件
set list                     " 显示特殊字符，其中Tab使用高亮~代替，尾部空白使用高亮点号代替
set listchars=tab:\~\ ,trail:.
set expandtab                " 将Tab自动转化成空格 [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
"set showmatch               " 显示括号配对情况
set wrap                  " 设置不自动换行
" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase
syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全

" ======= 引号 && 括号自动匹配 ======= "
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
:inoremap ` ``<ESC>i

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

" Show EOL type and last modified timestamp, right after the filename
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    "Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,git-rebase-todo setlocal fileencodings=utf-8

    "Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$")
                \           && expand("%") !~ "COMMIT_EDITMSG"
                \           && expand("%") !~ "ADD_EDIT.patch"
                \           && expand("%") !~ "addp-hunk-edit.diff"
                \           && expand("%") !~ "git-rebase-todo" |
                \   exe "normal g`\"" |
                \ endif

    autocmd BufNewFile,BufRead *.patch set filetype=diff
    autocmd BufNewFile,BufRead *.diff set filetype=diff

    autocmd Syntax diff
                \ highlight WhiteSpaceEOL ctermbg=red |
                \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

    autocmd Syntax gitcommit setlocal textwidth=74
endif " has("autocmd")


" 开启部分语法高亮的非默认特性
let g:cpp_class_scope_highlight           = 1               " 高亮C++ class scope
let g:cpp_experimental_template_highlight = 1               " 高亮C++ template functions

let python_highlight_all                  = 1               " 打开全部Python高亮

" BufExplorer         文件缓冲浏览器
let g:bufExplorerSortBy = 'name'               " 按文件名排序

" Tlist               调用TagList
let Tlist_Show_One_File        = 1             " 只显示当前文件的tags
let Tlist_Exit_OnlyWindow      = 1             " 如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_Use_Right_Window     = 1             " 在右侧窗口中显示
let Tlist_File_Fold_Auto_Close = 1             " 自动折叠

" snipMate            Tab智能补全
let g:snips_author = 'Ruchee'
if g:isWIN
    let g:snippets_dir = $VIM.'/snippets/'
else
    let g:snippets_dir = '~/.vim/snippets/'
endif
let g:snipMate                             = {}
" 不使用插件自带的默认继承
let g:snipMate.no_default_aliases          = 1
" 设置补全项之间的继承关系，比如 PHP补全继承HTML的补全
let g:snipMate.scope_aliases               = {}
let g:snipMate.scope_aliases['c']          = 'cpp,gtk'
let g:snipMate.scope_aliases['objc']       = 'objc,cpp'
let g:snipMate.scope_aliases['scheme']     = 'racket'
let g:snipMate.scope_aliases['php']        = 'php,html'
let g:snipMate.scope_aliases['typescript'] = 'typescript,javascript'
let g:snipMate.scope_aliases['scss']       = 'scss,css'
let g:snipMate.scope_aliases['less']       = 'less,css'
let g:snipMate.scope_aliases['xhtml']      = 'html'
let g:snipMate.scope_aliases['blade']      = 'blade,html'
let g:snipMate.scope_aliases['html.twig']  = 'twig,html'
let g:snipMate.scope_aliases['jinja.twig'] = 'twig,html'
let g:snipMate.scope_aliases['jinja']      = 'jinja,html'
let g:snipMate.scope_aliases['eruby']      = 'eruby,html'
let g:snipMate.scope_aliases['jst']        = 'jst,html'
let g:snipMate.scope_aliases['mustache']   = 'mustache,html'

" NERD_commenter      注释处理插件
let NERDSpaceDelims = 1                        " 自动添加前置空格
" 自动忽略的文件类型
let NERDTreeIgnore = ['.*\.o$','.*\.ko$','.*\.txt$','.*\.pyc$','tags']
let NERDTreeIgnore += ['.*\.rar$','.*\.zip$']

" Indent_guides       显示对齐线
let g:indent_guides_enable_on_vim_startup = 0  " 默认关闭
let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸

" AirLine             彩色状态栏
let g:airline_theme = 'badwolf'                " 设置主题

colorscheme default


" GitGutter           Git辅助插件
let g:gitgutter_enabled               = 0      " 默认不开启
let g:gitgutter_signs                 = 0      " 默认不开启提示
let g:gitgutter_highlight_lines       = 0      " 默认不高亮行
let g:gitgutter_sign_added            = '+'    " 自定义新增指示符
let g:gitgutter_sign_modified         = '>'    " 自定义修改指示符
let g:gitgutter_sign_removed          = '-'    " 自定义删除指示符
let g:gitgutter_sign_modified_removed = '->'   " 自定义既修改又删除指示符

" Syntastic           语法检查
let g:syntastic_check_on_open = 1              " 默认开启
let g:syntastic_mode_map      = {'mode': 'active',
            \'active_filetypes':  [],
            \'passive_filetypes': ['html', 'css', 'xhtml', 'go', 'groovy', 'scala', 'clojure', 'racket', 'typescript', 'eruby', 'slim', 'jade', 'scss', 'less']
            \}                                 " 指定不需要检查的语言 [主要是因为开启这些语言的语法检查会妨碍到正常的工作]
" 自定义编译器和编译参数
let g:syntastic_c_compiler = 'gcc'
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_c_compiler_options = '-std=c11 -Wall'
let g:syntastic_cpp_compiler_options = '-std=c++14 -Wall'

" javascript-libraries-syntax                    指定需要高亮的JS库
let g:used_javascript_libs = 'jquery,requirejs,backbone,underscore,prelude,angularjs,angularui,react'


" ======= 自定义快捷键 ======= "
let mapleader = ","
let g:mapleader = ","

" Fast saving
map <leader>w :w!<cr>
map <leader>W :w!<cr>
map <leader><leader>y <ESC>ggvG$"+y
map <leader><leader>r <ESC>ggvG$=
map <silent> <leader>q :q<cr>
map <silent> <leader>Q :q<cr>
map <leader>co :copen<cr>
map <leader>cl :cclose<cr>
map <silent><F2> :Tlist<cr>
map <silent><F3> :NERDTreeToggle<cr>
map <silent><F4> :BufExplorer<cr>
map <F12> :w!<cr>:!python.exe % <cr>
map <m-s> <c-e>
map <m-w> <c-y>
map <m-S> <c-e>
map <m-W> <c-y>
map <m-D> <c-d>
map <m-E> <c-u>
map <m-d> <c-d>
map <m-e> <c-u>
map <leader>te :e <c-r>=expand("%:p:h")<cr>/
" Ctrl + ]            tags选择性跳转
nmap <c-]> g<c-]>
vmap <c-]> g<c-]>

" Ctrl + H            光标移当前行行首[插入模式]、切换左窗口[Normal模式]
map <c-h> <c-w><c-h>

" Ctrl + K            光标移上一行行尾[插入模式]、切换上窗口[Normal模式]
imap <c-k> <ESC><Up>A
map <c-k> <c-w><c-k>

" Ctrl + L            光标移当前行行尾[插入模式]、切换右窗口[Normal模式]
imap <c-l> <ESC>A
map <c-l> <c-w><c-l>

" Alt  + H            光标左移一格
imap <m-h> <Left>

" Alt  + J            光标下移一格
imap <m-j> <Down>

" Alt  + K            光标上移一格
imap <m-k> <Up>

" Alt  + L            光标右移一格
imap <m-l> <Right>

" \c                  复制至公共剪贴板
vmap <leader>c "+y

" \a                  复制所有至公共剪贴板
nmap <leader>a <ESC>ggVG"+y<ESC>

" \v                  从公共剪贴板粘贴
imap <leader>v <ESC>"+p
nmap <leader>v "+p
vmap <leader>v "+p

nmap <leader>p <ESC>ggdG"+pgg
" \rb                 一键去除所有尾部空白
imap <leader>rb <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nmap <leader>rb :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
vmap <leader>rb <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" \rm                 一键去除字符
imap <leader>rm <ESC>:%s/<c-v><c-m>//g<CR>
nmap <leader>rm :%s/<c-v><c-m>//g<CR>
vmap <leader>rm <ESC>:%s/<c-v><c-m>//g<CR>

" press 0 to the front
map 0 ^

" <leader> ENTER: cancel the highlight
map <leader><cr> :nohl<cr>
" \rt                 一键替换全部Tab为空格
map <leader>rt :call RemoveTabs()<cr>
func! RemoveTabs()
    if &shiftwidth == 2
        exec "%s/	/  /g"
    elseif &shiftwidth == 4
        exec "%s/	/    /g"
    elseif &shiftwidth == 6
        exec "%s/	/      /g"
    elseif &shiftwidth == 8
        exec "%s/	/        /g"
    else
        exec "%s/	/ /g"
    end
endfunc


" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal g'\"" | endif
endif

"set fileencodings=ascii,gb2312,gbk,utf-8

"http://vim.wikia.com/wiki/List_lines_with_keyword_and_prompt_for_jump
" begin
function! s:JumpOccurrence()
    let v:errmsg = ""
    exe "normal [I"
    if strlen(v:errmsg) == 0
        let nr = input("Which one: ")
        if nr =~ '\d\+'
            exe "normal! " . nr . "[\t"
        endif
    endif
endfunction

" List occurrences of keyword entered at prompt, and
" jump to selected occurrence.
function! s:JumpPrompt()
    let keyword = input("Keyword to find: ")
    if strlen(keyword) > 0
        let v:errmsg = ""
        exe "ilist! " . keyword
        if strlen(v:errmsg) == 0
            let nr = input("Which one: ")
            if nr =~ '\d\+'
                exe "ijump! " . nr . keyword
            endif
        endif
    endif
endfunction
nnoremap <Leader>j :call <SID>JumpOccurrence()<CR>
"endif
func Search_Word()
    let w = expand("<cword>") " word at current cursor
    let p = expand("%:p:h") " path of current file
    exe "cd " p
    exe "grep " w "*.c *.py"
    exe 'copen'
endfun

map <leader>g :call Search_Word()<CR>


map <leader>re :call FormartSrc()<CR><CR>

"定义FormartSrc()
func! FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
        exec "normal gg=G"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc
"结束定义FormartSrc

" http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
function! <SID>StripTrailingWhitespace()
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
nmap <silent> <Leader><space> :call <SID>StripTrailingWhitespace()<CR>
nnoremap [I :call UnderOccurences()<CR>
function! UnderOccurences()
    exe "normal! [I"
    let nr = input("Which one: ")
    if nr == ""
        return
    endif
    exe "normal! " . nr . "[\t"
endfunction!

nnoremap [S :call <SID>FindOccurences()<CR>
function! s:FindOccurences()
    let pattern = input("Prompt Find: ")
    if pattern == ""
        return
    endif
    "   exe "ilist " . pattern // Robby Changed according to JumpPrompt()
    exe "ilist! " . pattern
    let nr = input("Which one: ")
    if nr == ""
        return
    endif
    exe "ijump " . nr . pattern
endfunction
"------------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
"------------------------------------------------------------------------------
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif

"------------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
"------------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
"------------------------------------------------------------------------------
"  < 编译、连接、运行配置 >
"------------------------------------------------------------------------------
" F9 一键保存、编译、连接存并运行
map <F5> :call Run()<CR>
imap <F5> <ESC>:call Run()<CR>

" Ctrl + F9 一键保存并编译
map <c-F5> :call Compile()<CR>
imap <c-F5> <ESC>:call Compile()<CR>

" Ctrl + F10 一键保存并连接
map <c-F8> :call Link()<CR>
imap <c-F8> <ESC>:call Link()<CR>

let s:LastShellReturn_C = 0
let s:LastShellReturn_L = 0
let s:ShowWarning = 1
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.exe'
let s:Sou_Error = 0

let s:windows_CFlags = 'gcc\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:windows_CPPFlags = 'g++\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

func! Compile()
    exe ":ccl"
    exe ":update"
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let s:Sou_Error = 0
        let s:LastShellReturn_C = 0
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        let v:statusmsg = ''
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            redraw!
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    else
        let s:Sou_Error = 1
        echohl WarningMsg | echo " please choose the correct source file"
    endif
    exe ":setlocal makeprg=make"
endfunc

func! Link()
    call Compile()
    if s:Sou_Error || s:LastShellReturn_C != 0
        return
    endif
    let s:LastShellReturn_L = 0
    let Sou = expand("%:p")
    let Obj = expand("%:p:r").s:Obj_Extension
    if g:iswindows
        let Exe = expand("%:p:r").s:Exe_Extension
        let Exe_Name = expand("%:p:t:r").s:Exe_Extension
    else
        let Exe = expand("%:p:r")
        let Exe_Name = expand("%:p:t:r")
    endif
    let v:statusmsg = ''
    if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
        redraw!
        if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
            if expand("%:e") == "c"
                setlocal makeprg=gcc\ -o\ %<\ %<.o
                echohl WarningMsg | echo " linking..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                setlocal makeprg=g++\ -o\ %<\ %<.o
                echohl WarningMsg | echo " linking..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_L = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_L != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " linking failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " linking successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " linking successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Exe_Name"is up to date"
        endif
    endif
    setlocal makeprg=make
endfunc

func! Run()
    let s:ShowWarning = 0
    call Link()
    let s:ShowWarning = 1
    if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
        return
    endif
    let Sou = expand("%:p")
    let Obj = expand("%:p:r").s:Obj_Extension
    if g:iswindows
        let Exe = expand("%:p:r").s:Exe_Extension
    else
        let Exe = expand("%:p:r")
    endif
    if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
        redraw!
        echohl WarningMsg | echo " running..."
        if g:iswindows
            exe ":!%<.exe"
        else
            if g:isGUI
                exe ":!gnome-terminal -e ./%<"
            else
                exe ":!./%<"
            endif
        endif
        redraw!
        echohl WarningMsg | echo " running finish"
    endif
endfunc
