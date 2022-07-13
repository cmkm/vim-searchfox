" Set `g:searchfox_url` to use a different URL than the default here
if !exists('g:searchfox_url')
  let g:searchfox_url = 'https://searchfox.org/mozilla-central/search?q='
endif

" Set `g:searchfox_directory` to use a different base directory
if !exists('g:searchfox_directory')
  let g:searchfox_directory = $HOME . "/mozilla-unified"
endif

function! s:searchfox_relevant_path()
  let l:searchfox_directory_mod = fnamemodify(g:searchfox_directory, ':p:h')
  let l:current_full_path = bufname('%')
  return substitute(l:current_full_path, l:searchfox_directory_mod, '', '')
endfunction

" Get Searchfox URL for the file currently open
function! searchfox#SearchfoxURL()
  let l:relevant_path = s:searchfox_relevant_path()
  let s:searchfox_url = g:searchfox_url . l:relevant_path
  if has('clipboard')
    let @* = s:searchfox_url
  endif
  execute 'silent !open ' . shellescape(s:searchfox_url, 1)
endfunction

function! searchfox#SearchfoxVisualURL()
  " From http://stackoverflow.com/a/6271254/794380
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let l:relevant_path = s:searchfox_relevant_path()
  let s:searchfox_url = g:searchfox_url . l:relevant_path . '#' . lnum1 . '-' . lnum2
  if has('clipboard')
    let @* = s:searchfox_url
  endif
  execute '!open ' . shellescape(s:searchfox_url, 1)
endfunction

" TODO: rename commands
command! -nargs=0 SearchfoxURL call searchfox#SearchfoxURL()
command! -range -nargs=0 SearchfoxVisualURL call searchfox#SearchfoxVisualURL()
