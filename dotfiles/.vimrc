runtime defaults.vim

"""" global variables

set number
set noshowmode
set cursorline
set updatetime=100
set nohlsearch
set mouse=a
set t_Co=256
colorscheme fox-colors

""" gui-specific stuff

set guifont=Monoid:h9
hi Normal guibg=#222222

""" terminal
tnoremap <Esc> <C-\><C-n>

autocmd TermOpen * nonumber

""" airline

let g:airline_theme='minimalist'
" let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" some powerline symbols are broken in monoid?
" patching it is odd, and i don't really care
let g:airline_symbols.branch = ''
let g:airline_symbols.linenr = 'l '
let g:airline_symbols.maxlinenr = ' c'

" let g:airline_symbols.linenr = '␊'

""" ale/file-specific linting

let g:ale_linters = {
\	'markdown': [],
\	'go': ['gopls'],
\	'javascript': ['standard'],
\	'javascriptreact': ['standard'],
\}

let g:ale_fixers = {
\	'*': ['remove_trailing_lines', 'trim_whitespace'],
\	'go': ['gofmt', 'goimports'],
\	'javascript': ['standard'],
\	'javascriptreact': ['standard'],
\}
let g:ale_fix_on_save = 1
let g:ale_rust_rls_config = {'rust': {'clippy_preference': 'on'}}
let g:rustfmt_autosave = 1

""" lsc_client

let g:lsc_server_commands = {
\	'go': {
\		'command': 'gopls serve',
\		'log_level': -1,
\		'suppress_stderr': v:true,
\	},
\	'rust': {
\		'command': 'rls',
\		'log_level': -1,
\		'suppress_stderr': v:true,
\	},
\	'python': {
\		'command': 'pylsp',
\		'log_level': -1,
\		'suppress_stderr': v:true,
\	},
\}
let g:lsc_auto_map = {
\	'defaults': v:true,
\}

autocmd CompleteDone * silent! pclose

" we're using standard, so two-space tabs for javascript
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType javascriptreact setlocal shiftwidth=2 softtabstop=2 expandtab

" alright, so i'm too used to HTML looking like this now
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab

" markdown limit to 80 characters, tabs at 2 spaces so that it's easier to do
" code blocks amongst other things, and no line numbers due to the
" automatic hard wrap
autocmd FileType markdown setlocal tw=80 shiftwidth=2 softtabstop=2 nonumber expandtab

" dart
autocmd FileType dart setlocal shiftwidth=2 softtabstop=2 expandtab

" c# (based on the SS14 code style)
autocmd FileType cs setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd BufNewFile,BufRead *.xaml setf xml
autocmd FileType xml setlocal shiftwidth=4 softtabstop=4 expandtab

"""" runtime stuff (mostly airline)

:packloadall

function! Foxbar()
	let g:airline_section_a = airline#section#create(['mode'])
	let g:airline_section_b = airline#section#create([])
	let g:airline_section_y = airline#section#create([])
	let g:airline_section_z = airline#section#create_right(['%l:%c', '%P% '])
endfunction
call Foxbar()

autocmd VimEnter * let g:airline_section_y = airline#section#create_right(['branch'])
