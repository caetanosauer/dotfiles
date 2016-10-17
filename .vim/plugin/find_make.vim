" Plugin to find the closest "build" directory and invoke make from there
" author: Caetano Sauer

if exists("loaded_find_make")
  finish
endif
let loaded_find_make = 1

" Utility function
" Thanks to tpope/vim-fugitive
function! s:fnameescape(file) abort
  if exists('*fnameescape')
    return fnameescape(a:file)
  else
    return escape(a:file," \t\n*?[{`$\\%#'\"|!<")
  endif
endfunction

function! s:find_build_dir(...)

  let s:build_dir = finddir('build', '.;')
  
  if s:build_dir !=""

    let &makeprg='make -C ' . shellescape(s:build_dir) . ' $*'
                \ . ' -j' . (system('grep -c ^processor /proc/cpuinfo')+0)

  endif

endfunction

" csauer: modified from autoload_cscope
augroup find_makeprg
 au!
 au BufEnter *.[chly]  call s:find_build_dir()
 au BufEnter *.cpp      call s:find_build_dir()
augroup END
