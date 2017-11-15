if get(g:,'loaded_compick',0) | fini | el | let g:loaded_compick=1 | en

au filetype compick-mru let b:compick_source=v:oldfiles
au filetype compick-cwd let b:compick_source=glob('{,.}*',0,1)
au filetype compick-git let b:compick_source=systemlist('git ls-files')
