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
	let @h = 'ggO# =====================================================# FileýaOýajki#ýajA Name: ýa"%po# Date of Creation: ýa:put = strftime(\"%c\")kJo# Author: Josiah Tan# Description:## =====================================================# =====================================================ýa'
	let @r = ":!python3 %\n"
	let @p = ':s/\(\s*\)\(.\+\)/\1print(f"\2 = {\2}")/j'
	let @b = "oif __name__ == '__main__':\n"
	let @d = "Oimport numpy as npimport pandas as pdimport matplotlib.pyplot as pltýa"
	let @t = 'O%run -n "~/.vim/templates/markdown"%run -n "~/.vim/templates/solve"ý'
	let @n = 'o##ý'
	let @s = '^v$hy^v$h:s/\%V /, /geA = symbols("ýap'
	let @e = ':s/ *\(^ *\|, \) *\([^=]\{-}\)\s*= *\([^,]\)/\1Eq(\2, \3)/g|s/^\(\s*\)/\1solve([/|s/$/])/'
	let @i = '^f(yi(o":s/ *\(^ *\|, \) *\([^=,]\{-}\)\s*= *\([^,]*\)/\1\2/ge^dt,:s/\(\s*\), *\([^,]\+\)/\1".\2 = \2,/g0yiw:s/,/\r"/g'
endfunction

" Global C family settings for header, c and cpp files
function SetCFamGlobalOptions()
	let @h = 'ggO/* File Name: ýa"%po Date of Creation: ýa:put = strftime(\"%c\")kJoAuthor: Josiah TanDescription: kbkbkbkbkb*/ýa'
	let @t = 'Sfor (int t=0;t<T;t++){ýaOýa'
	let @i = 'Sfor (int i=0;i<n;i++){ýaOýa'
	let @j = 'Sfor (int j=0;j<m;j++){ýaOýa'
	let @k = 'Sfor (int k=0;k<l;k++){ýaOýa'
	let @f = '$F(yi)O/*Description: 	pkbParameters:	ýap:s/, /:  *		/geA:kbReturns:ýajfýa$F(Bhy^kA		ýapA: kbkbkbkb*/ýaoýa?DescriptionAýa'
endfunction

" c settings
function SetCOptions()
	let @r = ":!gcc % && ./a.out\n"
	let @b = 'i#include<stdio.h>#include<stdlib.h>#include<limits.h>int main(void){ýaOretrnreturn 0;ýak'
	" let @m = 
endfunction

" cpp settings
function SetCPPOptions()
	let @r = ":!g++ % && ./a.out\n"
	let @b = 'i#include<iostream>#include<ckbvector>#include<alsotalgorithm>@kb#include<climits>#include<string>kbkbkbkbkbkbkbkbit kbkbnt main(void){ýaOreturn 0;ýakkOusing namespace std;ýa3jOint T; kbcin >> T;for (int ikbt=1;t<=T;t++){ýaOcout << "Case #" << t << ans << endl;ýaOans = 0;ýaIint ýa'
	" let @m = 
	let @p = '^v$hdacout << "ýapA << ýapA << end;kbl;ýaj'
endfunction

" .h settings
function SetHOptions()
	let @g = 'ýa"%p:s/\(\w\+\)\.\(\w\)/#ifndef \U\1_\U\2\e\r#define \U\1_\U\2/G10oýaI#endifýa2j'
	let @b = '@h@gi#define true 1#define false 0#define bool charýa'
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
