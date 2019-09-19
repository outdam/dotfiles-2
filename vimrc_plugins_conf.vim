" *********************************************
" UI
" *********************************************
" *** Colorscheme
" *********************************************
set termguicolors

" Force true colour on, since vim can’t detect it within tmux.
" The last line on its own will work outside tmux, but result in no colours inside tmux.
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_9b="\<Esc>[48;2;%lu;%lu;%lum"

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" OneDark
" let g:onedark_terminal_italics=1
" colorscheme onedark
"
" Gruvbox
" let g:gruvbox_italic=1
" let g:gruvbox_hls_cursor="aqua" " yank highlight
" let g:gruvbox_invert_selection=0
" let g:gruvbox_sign_column="bg0"
" let g:gruvbox_vert_split="bg1"
" let g:gruvbox_invert_tabline=1
" colorscheme gruvbox

" Ayu
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu

set background=dark
let g:palenight_terminal_italics=1
colorscheme palenight
"
" *** Airline
" *********************************************
" let g:airline_theme='gruvbox'
let g:airline_theme = "palenight"
let g:airline#extensions#tagbar#enabled = 0
let g:airline_powerline_fonts = 1
" let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ }
let g:airline_section_z = '%3p%% %3l/%L:%3v'
let g:airline_section_z = '%3p%% %3l/%L:%3v'
let g:airline#extensions#wordcount#formatter#default#fmt = '%d w'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" let g:airline_section_b = ""  " hide section b (git related)

" Changing 'modified' character to red 
" let g:airline_detect_modified = 0 "if you're sticking the + in section_c you probably want to disable detection
function! InitAirline()
  call airline#parts#define_raw('modified', '%{&modified ? "【✚" : ""}')
  call airline#parts#define_accent('modified', 'red')
  let g:airline_section_c = airline#section#create(['%f', 'modified'])
endfunction
autocmd VimEnter * call InitAirline()

" *** NERDTree
" *********************************************
map \ :NERDTreeToggle<CR>
map \| :NERDTreeFind<CR>
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapCloseDir = 'h'
let g:NERDTreeMapCloseChildren = 'H'
let g:NERDTreeMapRefresh = 'r'
let g:NERDTreeMapRefreshRoot = 'R'
let g:NERDTreeMapOpenSplit = 'sp'
let g:NERDTreeMapOpenVSplit = 'sv'
let NERDTreeHighlightCursorline=1
" let NERDTreeStatusline = "On %{fugitive#head()}"
let NERDTreeStatusline = ""
let NERDTreeIgnore = ['\.settings$', '\.editorconfig','node_modules$','\.idea$','\.envrc','yarn-error.log', 'rspec_examples.txt', '\.swp$', '\.DS_Store$', '\.git$', '\.bundle$', '.keep$', '^tags', 'tags.lock$', 'tags.temp$']
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let g:NERDTreeNodeDelimiter = "\u00a0" " hide ^G

" *** NERDTree Syntax Highlighting
" *********************************************
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

" *********************************************
" Editing
" *********************************************
" *** Gutentags
" *********************************************
au FileType gitcommit,gitrebase let g:gutentags_enabled=0

" *** Ack - Search
" *********************************************
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Abbreviating Ag to Ack!
cnoreabbrev Ag Ack!

" Quick Search - Binding ,f to find the word under cursor
nnoremap <leader>f :Ack! "\b<C-R><C-W>\b"<CR>

" Quick Search in visual mode
vmap <leader>f y:Ack! '<C-R>"'<CR>

" Write "Ack! `current word`" to vim command
nnoremap <leader>F :Ack!<Space>'<C-R><C-W>'

" Write "Ack! `current word`" to vim command - in visual mode
vmap <leader>F y:Ack! '<C-R>"'

" Promping Search and replace
nnoremap <leader>/ :call FindReplace('<C-R><C-W>','')<left><left>

" Promping Search and replace - Find and Replace
vmap <leader>/ y:call FindReplace('<C-R>"','')<left><left>

function! FindReplace(pattern,replace,...)
  let pattern = a:pattern
  let replace = a:replace
  let scope = a:0 >= 1 ? " -G ".a:1 : ""
  execute "Ack! '".pattern."'".scope
  execute "cdo %s/".pattern."/".replace."/gc | update"
endfunction

" *********************************************
" DEV tools
" *********************************************
" *** Ale
" *********************************************
" *** neomake
" *********************************************
" function! MyOnBattery()
"   if has('macunix')
"     return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
"   elsif has('unix')
"     return readfile('/sys/class/power_supply/AC/online') == ['0']
"   endif
"   return 0
" endfunction

" if MyOnBattery()
"   " When writing a buffer (no delay).
"   call neomake#configure#automake('w')
" else
"   " When reading a buffer (after 1s), and when writing (no delay).
"   call neomake#configure#automake('nw', 1000)
" endif
" *** Deoplete
" *********************************************
" let g:deoplete#enable_at_startup = 1
" " *** Deoplete-ternjs
" " *********************************************
" " " Whether to include the types of the completions in the result data. Default: 0
" let g:deoplete#sources#ternjs#types = 1
"
" *** COC
" *********************************************
" TODO
" - [ ] learn codeAction
" - [ ] learn fix-current
"
"
"" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" selections
  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)

" Formatting
  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Remap for format selected region
  xmap <c-f>  <Plug>(coc-format-selected)
  nmap <c-f>  <Plug>(coc-format-selected)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" coc-yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

"
" *** MatchTagAlways
" *********************************************
let g:mta_filetypes = {
    \'javascript.jsx': 1,
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
\}

"
" *** Ctrlp
" *********************************************
let g:ctrlp_clear_cache_on_exit = 0
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

if executable('ag')
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_prompt_mappings = { 'PrtInsert("c")':       ['<c-p>']}
  let g:ctrlp_match_window = 'max:20'         "max items in matched list
  let g:ctrlp_use_caching = 0
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden --skip-vcs-ignores -g "" --path-to-ignore ./.gitignore' " skip gitignore. Hidden files such as .travis.yml will be indexed for ag search
endif

" Highlighting ctrlp prompt
highlight CtrlPPrtCursor ctermbg=50

" Mapping key
nmap <leader><leader> :CtrlPBuffer<cr>

" CtrlP-CommandPalette
nnoremap <leader>? :CtrlPCommandPalette<cr>
let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s' " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore

"
" *** MarkdownPreview
" *********************************************
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

"
" *** Vim-Markdown
" *********************************************
let g:vim_markdown_new_list_item_indent = 2

" concealcursor is not working with indentLine
autocmd FileType markdown let g:indentLine_enabled = 0
autocmd FileType markdown set concealcursor="ni"

autocmd FileType markdown imap cbsh <esc>ciw```shell<cr><esc>O
autocmd FileType markdown imap cbjs <esc>ciw```javascript<cr><esc>O
autocmd FileType markdown imap cbyaml <esc>ciw```yaml<cr><esc>O

"
" *** Vim-Checkbox
" *********************************************

let g:insert_checkbox_prefix = '- '

" *** HighlightedYank
" *********************************************
" let g:highlightedyank_highlight_duration = 270
highlight! link HighlightedyankRegion Visual

"
" *** Vim Test
" *********************************************
let test#strategy = "dispatch"            " Using Dispatch strategy. Plugin 'tpope/vim-dispatch' is required'
let test#ruby#bundle_exec = 0
" let test#enabled_runners = ["ruby#rspec"] " select which runners to load by default, intead load all
nmap <silent> <leader>. :TestLast<CR>
nmap <silent> <leader>A :TestSuite<CR>
nmap <silent> <leader>R :TestFile -strategy=basic<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>g :TestVisit<CR>
nmap <silent> <leader>r :TestNearest -strategy=basic<CR>
nmap <silent> <leader>t :TestNearest<CR>

"
" Yggdroot/indentLine
" *********************************************
let g:indentLine_enabled = 0
let g:indentLine_char = '▏'
" let g:indentLine_concealcursor = 'inc'
" let g:indentLine_conceallevel = 2
map <leader>I :IndentLinesToggle<CR>

" Vim Better Whitespace
" *********************************************
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:better_whitespace_filetypes_blacklist=['vimrc']

"
" TagBar
" *********************************************

command! T TagbarToggle

  " Ripper-tags - OS executable
  if executable('ripper-tags') " gem install ripper-tags | ripper-tags -R --exclude=vendor
    let g:tagbar_type_ruby = {
        \ 'kinds'      : ['m:modules',
                        \ 'c:classes',
                        \ 'C:constants',
                        \ 'F:singleton methods',
                        \ 'f:methods',
                        \ 'a:aliases'],
        \ 'kind2scope' : { 'c' : 'class',
                         \ 'm' : 'class' },
        \ 'scope2kind' : { 'class' : 'c' },
        \ 'ctagsbin'   : 'ripper-tags',
        \ 'ctagsargs'  : ['-f', '-'],
        \ }
  endif

  " " Js
  " let g:tagbar_type_javascript = {
  "     \ 'ctagstype': 'javascript',
  "     \ 'kinds': [
  "     \ 'A:arrays',
  "     \ 'P:properties',
  "     \ 'T:tags',
  "     \ 'O:objects',
  "     \ 'G:generator functions',
  "     \ 'F:functions',
  "     \ 'C:constructors/classes',
  "     \ 'M:methods',
  "     \ 'V:variables',
  "     \ 'I:imports',
  "     \ 'E:exports',
  "     \ 'S:styled components'
  "     \ ]}

" Markdown2Ctags
" *********************************************
" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '/Users/outdam/.vim/plugged/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes --sro=»',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '»',
    \ 'kind2scope' : { 's' : 'section' },
    \ 'sort': 0,
    \ }



" easy-escape
" *********************************************
" The unit of timeout is in ms. A very small timeout makes an input of real jj
let g:easyescape_chars = { "j": 2 }
let g:easyescape_timeout = 100
inoremap jj <ESC>
