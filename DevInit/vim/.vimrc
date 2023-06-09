call plug#begin('~/.vim/plugged')
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/preservim/nerdtree.git'
Plug 'https://github.com/joshdick/onedark.vim.git'
Plug 'https://github.com/neoclide/coc.nvim.git'
Plug 'https://github.com/preservim/nerdtree.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
call plug#end()

" ======== base ==========
set cursorline                  " 高亮光标所在行
set backspace=2                 " 设置删除键
set foldlevelstart=99           " 打开文件默认不折叠代码
set fdm=syntax                  " 根据语法高亮来识别代码块折叠
set number                      " 开启显示行号-绝对行号
set expandtab                   " 将tab替换成空格
set tabstop=4                   " 设置tab长度为4个空格
set shiftwidth=4                " 设置自动缩进长度为4个空格，回车换行时会触发自动缩进
set autoindent                  " 新增加的行和前一行使用相同的缩进形式
set encoding=utf-8              " 设置vim内部的编码格式（如buffer、寄存器、脚本中的字符串）
set termencoding=utf-8          " 设置vim文本的编码显示格式
set fileencodings=utf-8         " 设置保存文本的编码格式列表，会在列表中进行识别格式并保存
set scrolloff=5                 " 光标移动到buffer的顶部和底部时保持3行距离
set cmdheight=1                 " 设置底部命令行只占一行的高度
set noruler                     " 设置不显示右下角的状态栏
set noshowmode                  " 设置不显示左下角（如INSERT）的状态栏
set noswapfile                  " 设置不生产swp文件
set nobackup                    " 表示不需要备份文件
set nowritebackup               " 表示编辑的时候不需要备份文件
set noundofile                  " 表示不创建撤销文件
set mouse=""                    " 关闭鼠标模式
syntax on                       " 开启语法高亮
colorscheme onedark             " 设置主题颜色
hi CursorLineNr cterm=bold ctermfg=blue     " 设置光标所在栏的行号，加粗、变前景色(fg)、背景色(bg)
hi VertSplit guibg=grey30 guifg=grey40      " 设置垂直的分割线样式"
nmap qq :q!<CR>                " 设置 qq 快捷键强制退出
nmap ss :wq!<CR>               " 设置 ss 快捷强键制保存退出
imap jj <ESC>                  " 设置 jj 快捷键快速退出编辑模式
nmap <space><tab> :bn<CR>      " 设置 space + tab 快捷键切换buffer
nmap <space>w :w<CR>           " 设置 space + w 快捷键快速保存
map <tab><UP> <ESC><C-W>-      " 设置调整窗口高度快捷键
map <tab><DOWN> <ESC><C-W>+    " 设置调整窗口高度快捷键
map <tab><LEFT> <ESC><C-W>>    " 设置调整窗口宽度快捷键
map <tab><RIGHT> <ESC><C-W><   " 设置调整窗口宽度快捷键
" ====== baseos end ======


" ======= onedark ========
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
" ===== onedark end =======


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


" ======== coc-snippets ========
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
" ====== coc-snippets end ======


" ======= nerdtree =========
nnoremap <C-t> :NERDTreeToggle<CR>       " 设置启动快捷键
let NERDTreeWinSize = 25                 " 设置启动宽度
let NERDTreeShowHidden = 1               " 设置显示隐藏文件
autocmd VimEnter * NERDTree | wincmd p   " 设置启动vim开启nerdtree，聚焦在主窗口
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" ===== nerdtree end =======


" ======= vim-airline =========
let g:airline_powerline_fonts = 1               " 启动电力线字体集成
let g:airline#extensions#tabline#enabled = 1    " 当只有一个选项卡打开时自动显示所有缓冲区
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_symbols = {'maxlinenr': ''}
let g:airline_section_c = ''
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = airline#section#create(['%p%%', 'maxlinenr'])    " 设置左下角Z部分的显示
let g:airline#extensions#nerdtree_statusline = 0    " nerdtree下标不显示
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'mixed-indent-file', 'conflicts' ]
" ===== vim-airline end =======


" ======= LeaderF =========
let g:Lf_WindowHeight = 0.35    " 设置窗口高度"
let g:Lf_ShowDevIcons = 0       " 关闭图标防止乱码
let g:Lf_ShowHidden=1           " 搜索显示隐藏文件
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_WindowPosition = 'bottom'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>
let g:Lf_GtagsAutoGenerate = 1    "打开第一个文件时自动生成gtags数据库,代码更新自动更新数据库
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
noremap <leader>fu :<C-U><C-R>=printf("Leaderf function %s", "")<CR><CR>
noremap <leader>rg :<C-U><C-R>=printf("Leaderf rg %s", "")<CR><CR>
" ===== LeaderF end =======


" ======= coc.nvim =========
set updatetime=300
set signcolumn=yes
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
nmap <leader>as  <Plug>(coc-codeaction-source)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <leader>cl  <Plug>(coc-codelens-action)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" ===== coc.nvim end =======

