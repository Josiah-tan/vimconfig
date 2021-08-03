" ################################################################ Global Macro Configurations  ################################################################

" vim macros documentation
"
" Python: h => heading, r => run python, p => print, b = code body, d => datascience, q => qtconsole (jupyter), t => ~/.vim/templates, n => ## code section breaks, s => symbols conversion, e => solve Eq, i => __init__ function automation
"
" CFam: h => heading, r => run (gcc/++ main.c && ./a.out), m => make (template with src and header files (todo) ), b => code body/ boolean.h (.h), p => print (only for c++)
" for loops <= (t, i, j, k), f => function commentary
"
" Header: g = guard headers
"
" Markdown: u = upper first letter of each word
" vim settings 

" Prerecorded macro settings for registers
" Python macro settings
function SetPythonOptions()
	let @h = 'ggO# =====================================================
	let @r = ":!python3 %\n"
	let @p = ':s/\(\s*\)\(.\+\)/\1print(f"\2 = {\2}")/
	let @b = "oif __name__ == '__main__':\n"
	let @d = "Oimport numpy as np
	let @t = 'O%run -n "~/.vim/templates/markdown"
	let @n = 'o
	let @s = '^v$hy^v$h:s/\%V /, /ge
	let @e = ':s/ *\(^ *\|, \) *\([^=]\{-}\)\s*= *\([^,]\+\)/\1Eq(\2, \3)/g|s/^\(\s*\)/\1solve([/|s/$/])/
	let @i = '^f(yi(o":s/ *\(^ *\|, \) *\([^=,]\{-}\)\s*= *\([^,]*\)/\1\2/ge
endfunction

" Global C family settings for header, c and cpp files
function SetCFamGlobalOptions()
	let @h = 'ggO/* 
	let @t = 'Sfor (int t=0;t<T;t++){
	let @i = 'Sfor (int i=0;i<n;i++){
	let @j = 'Sfor (int j=0;j<m;j++){
	let @k = 'Sfor (int k=0;k<l;k++){
	let @f = '$F(yi)O/*
endfunction

" c settings
function SetCOptions()
	let @r = ":!gcc % && ./a.out\n"
	let @b = 'i#include<stdio.h>
	" let @m = 
endfunction

" cpp settings
function SetCPPOptions()
	let @r = ":!g++ % && ./a.out\n"
	let @b = 'i#include<iostream>
	" let @m = 
	let @p = '^v$hdacout << "pA << pA << endl;j'
endfunction

" .h settings
function SetHOptions()
	let @g = '"%p:s/[\/\.]/_/ge
	let @b = '@hG@gi#define true 1
endfunction

" .md settings
function SetMDOptions()
	let @u = ':s/\w\+/\u&/ge
endfunction



" setting the macros for the file types

augroup MACROS
	autocmd!
	autocmd BufEnter *.py call SetPythonOptions()
	autocmd BufEnter *.c,*.cpp,*.h call SetCFamGlobalOptions()
	autocmd BufEnter *.c call SetCOptions()
	autocmd BufEnter *.cpp call SetCPPOptions()
	autocmd BufEnter *.h call SetHOptions()
	autocmd BufEnter *.md call SetMDOptions()
augroup END