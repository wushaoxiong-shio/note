
" ======== base ==========
set cursorline                  " 高亮光标所在行
set backspace=2                 " 设置删除键
set number                      " 开启显示行号-绝对行号
set expandtab                   " 将tab替换成空格
set tabstop=4                   " 设置tab长度为4个空格
set shiftwidth=4                " 设置自动缩进长度为4个空格，回车换行时会触发自动缩进
set autoindent                  " 新增加的行和前一行使用相同的缩进形式
set encoding=utf-8              " 设置vim内部的编码格式（如buffer、寄存器、脚本中的字符串）
set termencoding=utf-8          " 设置vim文本的编码显示格式
set fileencodings=utf-8         " 设置保存文本的编码格式列表，会在列表中进行识别格式并保存
set scrolloff=5                 " 光标移动到buffer的顶部和底部时保持5行距离
set cmdheight=1                 " 设置底部命令行只占一行的高度
set noswapfile                  " 设置不生产swp文件
set nobackup                    " 表示不需要备份文件
set nowritebackup               " 表示编辑的时候不需要备份文件
set noundofile                  " 表示不创建撤销文件
set mouse=""                    " 关闭鼠标模式
syntax on                       " 开启语法高亮
hi CursorLineNr cterm=bold ctermfg=blue     " 设置光标所在栏的行号，加粗、变前景色(fg)、背景色(bg)
" ====== baseos end ======


" ======= highlight =========
" 开启高亮类型斜体
hi Comment guifg=#56A6AE	" 设置注释颜色
hi Constant cterm=italic
hi Tag cterm=italic
hi Underlined cterm=italic
hi Ignore cterm=italic
hi Statement cterm=italic
hi Keyword cterm=italic
hi Conditional cterm=italic
hi Repeat cterm=italic
hi Structure cterm=italic
hi Boolean cterm=italic
hi Todo cterm=italic
hi Define cterm=italic
hi Macro cterm=italic
hi Include cterm=italic
hi Typedef cterm=italic
" ======= highlight =========
