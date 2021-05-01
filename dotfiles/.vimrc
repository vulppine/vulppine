runtime defaults.vim

"""" global variables

set number
set noshowmode
set cursorline
set updatetime=100
set t_Co=256
colorscheme fox-colors

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

let g:ale_completion_enabled = 1

let g:ale_linters = {
\	'go': ['gopls'],
\	'javascript': ['standard'],
\}

let g:ale_fixers = {
\	'*': ['remove_trailing_lines', 'trim_whitespace'],
\	'go': ['gofmt', 'goimports'],
\	'javascript': ['standard'],
\}
let g:ale_fix_on_save = 1

" we're using standard, so two-space tabs for javascript
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab

" alright, so i'm too used to HTML looking like this now
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab

" markdown limit to 80 characters
autocmd FileType markdown setlocal tw=80

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
