"  This Source Code Form is subject to the terms of the Mozilla Public
"  License, v. 2.0. If a copy of the MPL was not distributed with this file,
"  You can obtain one at http://mozilla.org/MPL/2.0/. 
"                          _      __          
"                         | |    / _|         
"  ___  ___  __ _ _ __ ___| |__ | |_ _____  __
" / __|/ _ \/ _` | '__/ __| '_ \|  _/ _ \ \/ /
" \__ \  __/ (_| | | | (__| | | | || (_) >  < 
" |___/\___|\__,_|_|  \___|_| |_|_| \___/_/\_\
"
" Global plugin for Searchfox utilities
" Maintainer: Cieara Meador <hello@cmkm.dev>                                             
"
" Commands:
" :SearchfoxFile
"     Get the Searchfox file URL for the file currently open in the active
"     buffer. Uses OS `open` utility, and copies the path to the clipboard, 
"     if supported. 
"
" :SearchfoxFileLines
"     In Visual mode (accepts a range), get the Searchfox file URL for the
"     file currently open in the active buffer, _and_ highlights selected
"     lines in the Searchfox interface.
"
" :SearchfoxSearchText
"     In Visual mode (accepts a range), perform a Searchfox search for the
"     text which is currently selected. NOTE: Currently recommend searching
"     only one line at a time. 

if exists('g:searchfox_plugin_loaded') || &cp
  finish
endif
let g:searchfox_plugin_loaded = 1

" Set `g:searchfox_url` to use a different repository URL than the default here
if !exists('g:searchfox_url')
  let g:searchfox_url = 'https://searchfox.org/mozilla-central/'
endif

let s:searchfox_search_url = g:searchfox_url . "search?q="
let s:searchfox_file_url = g:searchfox_url . "source/"

" Set `g:searchfox_directory` to use a different base directory
if !exists('g:searchfox_directory')
  let g:searchfox_directory = $HOME . '/mozilla-unified'
endif

function! s:searchfox_relevant_path()
  let l:searchfox_directory_mod = fnamemodify(g:searchfox_directory, ':p:h')
  let l:current_full_path = bufname('%')
  return substitute(l:current_full_path, l:searchfox_directory_mod, '', '')
endfunction

" Get Searchfox file URL for the file currently open
function! searchfox#SearchfoxFile()
  let l:relevant_path = s:searchfox_relevant_path()
  let s:searchfox_url = s:searchfox_file_url . l:relevant_path
  if has('clipboard')
    let @* = s:searchfox_url
  endif
  execute 'silent !open ' . shellescape(s:searchfox_url, 1)
endfunction

" Get Searchfox file URL for the file currently open, in visual mode;
" highlighted lines will be highlighted in Searchfox 
function! searchfox#SearchfoxFileLines()
  " From http://stackoverflow.com/a/6271254/794380
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let l:relevant_path = s:searchfox_relevant_path()
  let s:searchfox_url = s:searchfox_file_url . l:relevant_path . '#' . lnum1 . '-' . lnum2
  if has('clipboard')
    let @* = s:searchfox_url
  endif
  execute 'silent !open ' . shellescape(s:searchfox_url, 1)
endfunction

function! s:get_visual_selection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - 2]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

" Search on Searchfox for the text currently hightlighted in visual mode
" TODO: improve multiline support
function! searchfox#SearchfoxSearchText()
  let l:search = s:get_visual_selection()
  let s:searchfox_url = s:searchfox_search_url . l:search
  if has('clipboard')
    let @* = s:searchfox_url
  endif
  execute 'silent !open ' . shellescape(s:searchfox_url, 1)
endfunction

command! -nargs=0 SearchfoxFile call searchfox#SearchfoxFile()
command! -range -nargs=0 SearchfoxFileLines call searchfox#SearchfoxFileLines()
command! -range -nargs=0 SearchfoxSearchText call searchfox#SearchfoxSearchText()
