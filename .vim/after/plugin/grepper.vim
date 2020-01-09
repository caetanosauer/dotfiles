" Mappings using leader key
nmap <Leader>ga :Grepper -tool rg<cr>
nmap <Leader>gb :Grepper -tool rg -buffer<cr>
nmap <Leader>gg :Grepper -tool git<cr>

" gs operator searches with current selection or with given motion (e.g., gsiw)
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" when prompt is opened, start typing inside quotes
let g:grepper.prompt_quote = 2

" limit of entries to return in a search (Default was 5k)
let g:grepper.stop = 100000
