"============================================================================
"File:        fsc.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Gregor Uhlenheuer <kongo2002 at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

if exists('g:loaded_syntastic_scala_fsc_checker')
    finish
endif
let g:loaded_syntastic_scala_fsc_checker = 1

if !exists('g:syntastic_scala_options')
    let g:syntastic_scala_options = ''
endif

function! SyntaxCheckers_scala_fsc_GetLocList() dict
    " fsc has some serious problems with the
    " working directory changing after being started
    " that's why we better pass an absolute path
    let makeprg = self.makeprgBuild({
        \ 'args': '-Ystop-after:parser ' . g:syntastic_scala_options,
        \ 'fname': syntastic#util#shexpand('%:p') })

    let errorformat =
        \ '%E%f:%l: %trror: %m,' .
        \ '%Z%p^,' .
        \ '%-G%.%#'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'scala',
    \ 'name': 'fsc'})
