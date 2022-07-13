# vim-searchfox

This is a utility for vim users who work with Searchfox. This plugin lets you quickly search on Searchfox for the file currently in your active buffer. 

## configuration
You should override these variables in your `.vimrc`: 

### base directory
```
let g:searchfox_directory = '/Users/you/dev/mozilla-central/'
```
This should be the top-level directory where your source code lives. This should end in a trailing slash. 

### repository
```
let g:searchfox_url = 'https://searchfox.org/mozilla-central/'
```
This is the repository you want to search against on Searchfox. 

## commands
`:SearchfoxFile` - Open the Searchfox source for the current file.  

`:SearchfoxFileLines` - For use in visual mode. Open the Searchfox source for the current file, with your highlighted lines also highlighted in Searchfox. 

`:SearchfoxSearchText` - For use in visual mode. Uses your selected text as a search query. :warning: NOTE: Currently recommended for only a single line at a time. 

## installation
### vim 8+ native

`git clone` this repo into `~/.vim/pack`

### [vim-plug](https://github.com/junegunn/vim-plug)

`Plug 'cmkm/vim-searchfox'`

### [Vundle](https://github.com/VundleVim/Vundle.vim)

`PluginInstall 'cmkm/vim-searchfox'`
