" ################################################################ Global Macro Configurations  ################################################################

" vim macros documentation
"
" Python: h => heading, r => run python, p => print, b = code body, d => datascience, q => qtconsole (jupyter), t => ~/.vim/templates, n => ## code section breaks, s => symbols conversion, e => solve Eq, i => __init__ function automation, a => get value from key from ans
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
	let @h = 'ggO# =====================================================# File Name: "%po# Date of Creation: :put = strftime(\"%c\")kJo# Author: Josiah Tan# Description: ## =====================================================# =====================================================?Descri$'
	let @r = ":!python3 %\n"
	let @p = ':s/\(\s*\)\(.\+\)/\1print(f"\2 = {\2}")/j'
	let @b = "oif __name__ == '__main__':\n"
	let @d = "Oimport numpy as npimport pandas as pdimport matplotlib.pyplot as plt"
	let @t = 'O%run -n "~/.vim/templates/python/markdown"%run -n "~/.vim/templates/python/solve"'
	let @n = 'oi##'
	let @s = '^v$hy^v$h:s/\%V /, /geA = symbols("p'
	let @e = ':s/ *\(^ *\|, \) *\([^=]\{-}\)\s*= *\([^,]\+\)/\1Eq(\2, \3)/g|s/^\(\s*\)/\1ans = solve([/|s/$/])/'
	let @a = ':s/\(\s*\)\(\w*\)/\1\2 = ans[\2]j'
	let @i = '^f(yi(o":s/ *\(^ *\|, \) *\([^=,]\{-}\)\s*= *\([^,]*\)/\1\2/ge^dt,:s/\(\s*\), *\([^,]\+\)/\1".\2 = \2,/g0yiw:s/,/\r"/g'
endfunction

" Global C family settings for header, c and cpp files
function SetCFamGlobalOptions()
	let @h = 'ggO/* File Name: "%po Date of Creation: :put = strftime(\"%c\")kJoAuthor: Josiah TanDescription:xs*/?Descri$'
	let @t = 'Sfor (int t=0;t<T;t++){O'
	let @i = 'Sfor (int i=0;i<n;i++){O'
	let @j = 'Sfor (int j=0;j<m;j++){O'
	let @k = 'Sfor (int k=0;k<l;k++){O'
	let @f = '$F(yi)O/*Description: 	Parameters:	p:s/, /:  *		/geA:�kbReturns:j$F(Bhy^kA		pA:xs*/?Description'
endfunction

" c settings
function SetCOptions()
	let @r = ":!gcc % && ./a.out\n"
	let @b = 'i#include<stdio.h>#include<stdlib.h>#include<limits.h>int main(void){koreturn 0;k'
	" let @m = 
endfunction

" cpp settings
function SetCPPOptions()
	let @r = ":!g++ % && ./a.out\n"
	let @b = 'i#include<iostream>#include<vector>#include<algorithm>#include<climits>#include<string>int main(void){koreturn 0;kkOusing namespace std;3jOint T;cin >> T;for (int t=1;t<=T;t++){Ocout << "Case #" << t << ans << endl;Oans = 0;Iint '
	" let @m = 
	let @p = '^v$hdacout << "pA << pA << endl;j'
endfunction

" .h settings
function SetHOptions()
	let @g = '"%p:s/[\/\.]/_/geVUS#ifndef "#define "10oI#endif8k'
	let @b = '@hG@gi#define true 1#define false 0#define bool charýa'
endfunction

" .md settings
function SetMDOptions()
	let @u = ':s/\w\+/\u&/ge'
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
