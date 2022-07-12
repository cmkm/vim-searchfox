# vim-searchfox

This is a utility for vim users who work with Searchfox. This plugin lets you quickly search on Searchfox for the file currently in your active buffer. 

## variables
You should override these variables in your `.vimrc`: 

### `g:searchfox_directory`
```
let g:searchfox_directory = '/Users/you/dev/mozilla/'
```

## commands
`:SearchfoxURL` - Open a Searchfox search for the current file.  

`:SearchfoxVisualURL` - For use in visual mode. Open a Searchfox search for the current file, with your highlighted lines also highlighted in Searchfox. 
