" 2022.07.11

" Set `g:searchfox_url` to use a different URL than the default here
if !exists('g:searchfox_url')
  let g:searchfox_url = 'https://searchfox.org/mozilla-central/search?q='
endif

" TODO
let g:directory_location = '/Users/cmeador/dev/gecko/'
let s:directory_location_length = len(g:directory_location)
let s:relevant_path_start_index = s:directory_location_length - 1

function! s:searchfox_relevant_path(path)
  
endfunction

" Get Searchfox URL for the file currently open
function! searchfox#SearchfoxURL()
  let l:current_full_path = bufname('%')
  let l:relevant_path = l:current_full_path
  if stridx(l:current_full_path, g:directory_location) >= 0
    let l:relevant_path = l:current_full_path[s:relevant_path_start_index : len(l:current_full_path)]
  endif
  let s:searchfox_url = g:searchfox_url . l:relevant_path
  if has('clipboard')
    let @* = s:searchfox_url
  endif
  execute "!open '" . s:searchfox_url . "'"
  echo s:searchfox_url
endfunction

" WIP: Get Searchfox URL for file currently open, at highlighted lines
function! searchfox#SearchfoxVisualURL()
  " From http://stackoverflow.com/a/6271254/794380
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let s:searchfox_url = g:searchfox_url . bufname('%') . "#" . lnum1 . "-" . lnum2
  if has('clipboard')
    let @* = s:searchfox_url
  endif
  execute "!open '" . s:searchfox_url . "'"
  echo s:searchfox_url
endfunction

" TODO: rename commands
command! -nargs=0 SearchfoxURL call searchfox#SearchfoxURL()
command! -range -nargs=0 SearchfoxVisualURL call searchfox#SearchfoxVisualURL()
