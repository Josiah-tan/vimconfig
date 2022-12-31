" https://stackoverflow.com/questions/3578549/what-is-the-easiest-way-to-swap-occurrences-of-two-strings-in-vim
function! Mirror(dict)
    for [key, value] in items(a:dict)
        let a:dict[value] = key
    endfor
    return a:dict
endfunction
function! SwapWords(dict, ...)
    let words = keys(a:dict) + values(a:dict)
    let words = map(words, 'escape(v:val, "|")')
    if(a:0 == 1)
        let delimiter = a:1
    else
        let delimiter = '/'
    endif
    let pattern = '\v(' . join(words, '|') . ')'
    exe 's' . delimiter . pattern . delimiter
        \ . '\=' . string(Mirror(a:dict)) . '[submatch(0)]'
        \ . delimiter . 'g'
endfunction
