# compick.vim
A completion-based general-purpose picker for vim

## What
This plugin is yet another finder like
[Denite](https://github.com/Shougo/denite.nvim) or
[FZF](https://github.com/junegunn/fzf.vim), with the following features:

* Leverages vim's built-in completion UI for choosing results;
* Easy customization: `au FileType compick-<type> let b:compick_...`;
* [Very](autoload/compick.vim) [small](plugin/compick.vim).

## Quickstart
```vim
nnoremap <leader>foo :call compick#do('mru')<cr>
nnoremap <leader>bar :call compick#do('cwd')<cr>
nnoremap <leader>baz :call compick#do('git')<cr>
```

## Buffer-local variables
* `b:compick_source`: List of strings or completion items to pick from. See `:h
  complete-items`. Default `[]`.
* `b:compick_action`: Function name or funcref that takes the picked completion
  item's `word` and does something. [Default](autoload/compick.vim#L27-L29)
* `b:compick_filter`: Function name or funcref that takes the completion items
  and the current line, and returns the filtered items. Here you might want to
  use a custom fuzzy matching function.
  [Default](autoload/compick.vim#L31-L34)
* `b:compick_format`: Function name or funcref that takes a completion item's
  index and value, and returns a completion item. Used for styling completion
  items. [Default](autoload/compick.vim#L36-L38)

## Functions
* `compick#do(type[,split])`: Opens a picker buffer of filetype
  `compick-<type>` in the given split (default `bottom 1 split`).
* `compick#popup()`: Opens the completion popup window with the buffer's
  source.
* `compick#accept(line)`: Calls the buffer's set action with `line`.

## Customizing a picker type
```vim
au FileType compick-* setlocal noshowmode
au FileType compick-mru inoremap <buffer>foo ...
```

## Defining a picker type
```vim
au FileType compick-buf let b:compick_source=map(filter(range(1,bufnr('$')),'bufloaded(v:val) && buflisted(v:val)'),'{"word":v:val,"abbr":v:val.':'.bufname(v:val)}')
au FileType compick-buf let b:compick_action={word->execute('b '.word)}
nnoremap <leader>b :call compick#do('buf')<cr>
```

See also the [built-in](plugin/compick.vim#L3-L5) types.

## Caveats
* Can't pick two items at once.
