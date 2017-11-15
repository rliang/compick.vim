fu! compick#do(type,...)
  exe a:0>=1 ? a:1 : 'bot 1 sp'
  ene
  let b:compick_source=[]
  let b:compick_action='s:default_action'
  let b:compick_filter='s:default_filter'
  let b:compick_format='s:default_format'
  star
  setl nobl bt=nofile ut=0 cot=menuone,noinsert,preview
  au cursorholdi,cursormovedi,vimresized <buffer> cal compick#popup()
  ino <buffer><esc> <esc>:q<cr>
  ino <buffer><cr> <c-y><esc>:cal compick#accept(getline('.'))<cr>
  let &ft=printf('compick-%s',a:type)
endf

fu! compick#popup()
  let items=map(deepcopy(b:compick_source),'type(v:val)==type("") ? {"word":v:val} : v:val')
  cal complete(1,map(call(b:compick_filter,[items,getline('.')]),function(b:compick_format)))
endf

fu! compick#accept(line)
  let A=b:compick_action
  bd!
  cal call(A,[a:line])
endf

fu! s:default_action(line)
  exe 'e' a:line
endf

fu! s:default_filter(items,line)
  let pattern='\V'.substitute(a:line,'\s\+','\\.\\*','g')
  retu filter(a:items,'get(v:val,"abbr",v:val["word"])=~pattern')
endf

fu! s:default_format(idx,item)
  retu extend(a:item,{'abbr':printf('%-*s',&co-len(&ft)-2,get(a:item,'abbr',a:item['word'])),'menu':&ft})
endf
