" wttr.vim
" A Vim plugin that displays data from 'http://wttr.in' inside the editor
" Author: Christian Haudum <christian@haudum.dev>
"

if exists('g:loaded_wttr') | finish | endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

" command to run our plugin
command! -nargs=? Wttr lua require('wttr').weather(<f-args>)

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_wttr = 1
