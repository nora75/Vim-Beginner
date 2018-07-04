scriptencoding utf-8
" こいつ↑は必ず一番上に
" このファイルでは折り畳みが有効化されているので折り畳み関連のコマンド↓
" zR:折り畳みを全て開く
" zM:折り畳みを全て閉じる
" zo:カーソルの下の折り畳みを1レベル開く
" zO:カーソルの下の折り畳みを全て開く
" zO:カーソルの下の折り畳みを全て開く

"===========================================================================
" 日本語版の設定ファイル(vimrc) for Vim 8.1 {{{1
"
" Description: Provide many settings for vim beginner only support vim 8.1
" Last Change: 03-Jul-2018.
" Maintainer:  NORA75
" Licence: MIT
"
" 解説: {{{1
" 各オプションの上部にコメントが書かれています
" コメントには説明と、その後にその設定を無効化する、または(乂･д･´)反対!の動作をする設定が書かれています
" このファイル内に個人的な設定を書かないで下さい(Ex:プラグインの設定等)
" このファイル内とは異なる値を設定したい場合、このファイル**読み込み後**に各自で設定して下さい
" エンコードの設定は危険なため、このファイルには入ってません、各自で設定して下さい、また、このファイルはutf-8で書かれています
" エンコードの設定の例:
"---------------------------------------------------------------------------
" ファイルのエンコーディングの設定(utf-8にする設定): {{{2

"---------------------------------------------------------------------------
" vim内部のエンコーディング: {{{3

if &enc !=# 'utf-8'
  set enc=utf-8
endif

"---------------------------------------------------------------------------
" ファイル読み込み時のエンコーディング: {{{3

if &fencs !=# 'ucs-bom,utf-8,sjis'
  set fileencodings=ucs-bom,utf-8,sjis
endif

"---------------------------------------------------------------------------
" ファイル書き出し時のエンコーディング: {{{3

if &fenc !=# 'utf-8'
  set fileencoding=utf-8
endif

" また、githubに上げているため、gitまたはプラグイン管理プラグイン等を利用する事をオススメします
" 
" 設定例: {{{1
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
" set ignorecase
" 上記のように書かれている場合、以下のようにvimrcに書くことによって設定が変更できます
" set noignorecase
"
" 参考:
"   :help tutor
"   :help vimrc
"   :vimtutor / :TUTORIAL
"   :help index.html
"   :help usr_02

"===========================================================================
" これは必須 {{{1

if has('kaoriya') && has('vim_starting')
  " add all folder under the $vim/plugins to rtp
  for s:path in split(glob($VIM.'/plugins/*'), '\n')
    if s:path !~# '\~$' && isdirectory(s:path)
      let &runtimepath = &runtimepath.','.s:path
    end
  endfor
  unlet s:path

  " fix for windows
  " don't add $vim not yet can't read exe files on windows
  if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
    let $PATH = $VIM . ';' . $PATH
  endif

  " vimproc: disable vimproc included with KaoriYa
  if kaoriya#switch#enabled('disable-vimproc')
    let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimproc$"'), ',')
  endif

  " go-extra: disable go-extra included with KaoriYa
  if kaoriya#switch#enabled('disable-go-extra')
    let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]golang$"'), ',')
  endif

  " Disable Screen Mode (kaoriya)
  let g:plugin_scrnmode_disable = 'yes'

  " kaoriya command disable
  let g:plugin_cmdex_disable = 1

  " for KaoriYa's plugins

  " correspond auto wrap word in Japanese
  set formatoptions+=mM
  " Setting for os which recognize upper/lower file name same
  "
  if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMRC')
    " prevent tag file dupricate
    set tags=./tags,tags
  endif

  try
    " autofmt: format function that support Japanese
    set formatexpr=autofmt#japanese#formatexpr()
  catch
  endtry

  " correspond move slow when $display is set
  if !has('gui_running') && has('xterm_clipboard')
    set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
  endif

endif

"===========================================================================
" 検索の挙動に関する設定: {{{1
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" サーチ時に即ハイライト (このファイルに変更を加えない限り<ESC>二回で切り換え可能)
set hlsearch
" インクリメンタルサーチ (noincsearch:インクリメンタルしない)
set incsearch

"===========================================================================
" ファイル編集に関する設定: {{1

" タブの画面上での幅
set tabstop=8
" タブをスペースに展開する (noexpandtab:展開しない)
set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" 自動インデントの強化 (nosmartindentもしくは未設定:高度なインデントの未使用)
set smartindent
" バックスペースでインデントや改行を削除できるようにする (eol:行末,start:行頭)
set backspace=indent,eol,start
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" クリップボードの共有 (set clipboard=:共有しない)
if has('xterm_clipboard') || has('gui')
  if has('unnamedplus')
    set clipboard+=unnamed,unnamedplus
  else
    set clipboard+=unnamed
  endif
endif
" コマンドの結果が一杯になった時に少しづつ見れるように (nomore:スキップする)
set more
" 補完を強力に (nowildmenu:非力)
" コマンドの履歴の保存する数 (多くてもパフォに問題ない)
set history=100
" うるせぇ (set belloff=:デン!!)
set belloff=all
" <BS>,<Space>,h,lで行末、行頭時移動可能に (set whichwrap=:いじる必要ないけどね)
set whichwrap=b,s,h,l
" ファイルに変更があったら自動で読み込む (noarutoread:自動で読み込まない、編集
" 中の時とかに自動で読み込まれてキレても知らん)
set autoread
" これ消さなーい (nomodeline:無効化)
" ファイルの一番下のなんか変なやつで、この書式でこのファイルを
" 開いた時に自動で設定を適用する奴、適用可能オプションは少ないかつ安全に実行さ
" れるのでウイルス等はない
set modeline

"===========================================================================
" guiの場合の設定: {{{1

if has('gui')
  set guioptions+=M
  " スクロールバーうざい
  " don't fork when start
  set guioptions+=f
  " don't show tool bar
  set guioptions-=T
  " don't show menu bar
  set guioptions-=m
  " don't show any scroll bar
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set guioptions-=b

  " カーソルうざい
  set guicursor=a:blinkon0
  "  マウス使用可能にしない
  set mouse+=a

  " 最大化して起動
  augroup gui
    au!
    au GUIEnter * simalt ~x
  augroup END

  syntax enable
  " 背景黒にしたいならアンコメント
  " set background=dark

  " change to if statement
  if has('win32')
    set linespace=1
    " 日本語とかをいい感じに
    if has('kaoriya')
      set ambiwidth=auto
    endif
  elseif has('xfontset')
    " for unix
    set guifontset=a14,r14,k14
  endif

  "===========================================================================
  " guiじゃない場合の設定: {{{1
else

  syntax on
  " 背景黒にしたいならアンコメント
  " set background=dark

endif

"===========================================================================
" GUI固有ではない画面表示の設定: {{{1
"
" 行番号を表示 (nonumber:非表示)
set number
" ルーラーを非表示 (ruler:表示)
set noruler
" タブや改行を非表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 行が画面に入り切らない場合折り返す (nolinebreak:折り返さない)
set linebreak
" タブページのラベル (↑にあるやつ常時表示,0:非表示,1:必要時表示)
set showtabline=2
" 常にウィンドウのサイズを一定に (noequalalways:あんま意味ないこのオプション)
set equalalways
" コマンドライン(下)の置換(:%sとかのやつ)の行のサイズ (任意の値:多くても2がベ
" スト好みで1)
set cmdheight=2
" vsコマンド等でウィンドウを分割時に必ず右に開く (nospr/nosplitright:右に開かない(左に開く))
set splitright

"===========================================================================
" ファイル操作に関する設定: {{{1
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set nobackup
" ファイルのフォーマットの設定 (左から優先度順)
set fileformats=unix,dos,mac
" スワップファイル作らなーい
set noswf
" アンドゥファイル作らなーい
if has('persistent_undo')
  set noundofile
endif

"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定: {{{2
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

"===========================================================================
" 日本語に関する設定: {{{1

if has('multi_byte_ime') || has('xim')
  " change cursor color when IME is enabled
  highlight CursorIM guibg=Purple guifg=NONE
  " set default IME status in insert/serch mode
  set iminsert=0 imsearch=0
endif

"===========================================================================
" ステータスライン(下に表示されてる奴)の設定: {{{1

" 左から
" + 現在のディレクトリ
" + 現在編集してるファイルのディレクトリ
" + (>ω<)わふーっ!
" + ファイルの名前
" + \+マークが付いてる時は編集中のファイルに変更があって保存されてない
" + ROは読み込み専用
"  右から
"   + 現在のファイルの拡張子(Vimが内部で判定したもの、これによって設定とか色々自動で変えさせる事が可能)
" + 編集中のファイルの文字コード
" + ファイルの改行コードがW(in)/U(nix)/M(ac)のどれか
" + 最後に検索(置換)した文字列

"=--------------------------------------------------------------------------
" Declation of wafu: {{{2

let s:wafun = '(>ω<)'
" let s:wafun = '(>ω<)           '
let s:wafuw = '(>ω<)/ わふーっ!'
let s:wafuel = '(>ω<) わふーっ! しすてむ・えらーですーっ!'
let s:wafues = '(>ω<) えらーですーっ!'
" let s:wafun = '(>ω<)                                   '
" let s:wafuw = '(>ω<)/わふーっ!                        '
" let s:wafue = '(>ω<)わふーっ! しすてむ・えらーですーっ!'
let s:wafustr = []
let s:wafuerrlong = []
let s:wafuerrshort = []
let i = 0
while i < 6
  call add(s:wafustr,s:wafun)
  call add(s:wafuerrshort,s:wafun)
  call add(s:wafuerrlong,s:wafun)
  let i += 1
endwhile
let i = 0
while i < 6
  call add(s:wafustr,s:wafuw)
  call add(s:wafuerrshort,s:wafues)
  call add(s:wafuerrlong,s:wafuel)
  let i += 1
endwhile

"---------------------------------------------------------------------------
" Functions: {{{2

"---------------------------------------------------------------------------
" MyStl() abort: {{{3
" function of setting statusline value
" number name variable is separator (colorscheme or alignment)

func! s:stl(active) abort
  call s:col()
  let first = ''
  let cfd = StlCurFileDir()
  let cwd = ''
  let waf = ''
  let second = ' %#StlLeft1# %f '
  if !a:active
    let cwd = StlCwd()
    let waf = ' | '.StlWafu()
    let first = '%#StlLeft0# '
  endif
  let mo = s:mod()
  let ro = s:ro()
  let third = '%#StlCent#%='
  let forth = '%#StlRight0#'
  let ff = '%{(&ft!="help")?''| ''.toupper(strcharpart(&ff,-1,2)).'' '':""}'
  let fenc = ' '.StlFenc().' '
  let ft =  '%{"| ".&ft." "}'
  return first.cwd.cfd.waf.second.mo.ro.third.ff.forth.fenc.ft
endfunc

"---------------------------------------------------------------------------
" StlCwd() abort: {{{3
" functino of cwd
" return current dir
" only end two directory
" show which partition if current directory's partition isn't match
" home directory's partition

func! StlCwd() abort
  let fcwd = getcwd()
  let cd = matchstr(fcwd,'\M^\/\?\zs\[^\\\/]\+\ze\(\/\|\\\)\?')
  let cwd = matchstr(fcwd,'\M\[^\\\/]\+\(\\\|\/\)\[^\\\/]\+$')
  if cwd ==# ''
    let cwd = fcwd
  endif
  let licwd = split(cwd, '\')
  let i = 0
  while i < len(licwd)
    if len(licwd[i]) > 5
      let licwd[i] = strcharpart(licwd[i],0,5)
    endif
    let i += 1
  endwhile
  let cwd = join(licwd, '\')
  if cd !~? matchstr(expand('~'),'\M^\/\?\zs\[^\\\/]\+\ze\(\/\|\\\)\?')
    let cd = toupper(cd)
    if cwd !~? '^'.strcharpart(cd,0,5)
      if cd !~ ':$'
        let cwd = cd.':'.cwd
      else
        let cwd = cd.cwd
      endif
    endif
  endif
  return cwd
endfunc

"---------------------------------------------------------------------------
" StlCurFileDir() abort: {{{3
" if current file dir isn't match current working director
" return current file directory

func! StlCurFileDir() abort
  let cwd = getcwd()
  let cfd = expand('%:p:h')
  if (cwd==?cfd)||(cfd==#'')
    return ''
  endif
  let cdr = strcharpart(cfd,-1,2)
  let cfd = matchstr(cfd,'[^\\]\+\\[^\\]\+$')
  if (strcharpart(cwd,-1,2)!=cdr) && (cfd!~'\M^'.cdr)
    let cdr = cdr.':'
  else
    let cdr = ''
  endif
  let licwd = split(cfd, '\')
  let i = 0
  while i < len(licwd)
    if len(licwd[i]) > 5
      let licwd[i] = strcharpart(licwd[i],0,5)
    endif
    let i += 1
  endwhile
  let cwd = join(licwd, '\')
  return cdr.cwd
endfun

"---------------------------------------------------------------------------
" StlWafu() abort: {{{3
" function of wafu
" return some variation of wafu

function! StlWafu()
  let wafuenc = get(s:, 'wafuenc', &encoding)
  if wafuenc != &encoding
    let s:wafustr = map(s:wafustr, 'iconv(v:val,s:wafuenc,&encoding)')
    let s:wafuerrlong = map(s:wafuerrlong, 'iconv(v:val,s:wafuenc,&encoding)')
  endif
  let s:wafuenc = &encoding
  let wafupos = get(w:, 'wafupos', -1) + 1
  if len(v:errmsg) && wafupos >= 0
    let wafupos = -24
    let s:lasterrormsg = v:errmsg
    let v:errmsg = ''
  endif
  if wafupos >= 0
    let wafupos = wafupos % len(s:wafustr)
  endif
  let w:['wafupos'] = wafupos
  if wafupos >= 0
    return s:wafustr[wafupos]
  else
    if winwidth('') >= 100
      return s:wafuerrlong[(wafupos+24) % len(s:wafuerrlong)].' '.matchstr(get(s:, 'lasterrormsg', ''),'^E\d\+')
    else
      return s:wafuerrshort[(wafupos+24) % len(s:wafuerrshort)].' '.matchstr(get(s:, 'lasterrormsg', ''),'^E\d\+')
    endif
  endif
endfunction

"---------------------------------------------------------------------------
" s:col() abort: {{{3
" function of declation colorscheme

func! s:col() abort
  hi StlLeft0 term=bold gui=bold ctermfg=22 ctermbg=148 guifg=#005f00 guibg=#afdf00
  hi StlLeft1 ctermfg=231 ctermbg=240 guifg=#ffffff guibg=#585858
  hi StlRight0 term=bold gui=bold ctermfg=241 ctermbg=252 guifg=#606060 guibg=#d0d0d0
  hi StlRight1 term=bold gui=bold ctermfg=231 ctermbg=240 guifg=#ffffff guibg=#585858
  hi StlCent term=bold gui=bold ctermfg=235 ctermbg=235 guifg=#262626 guibg=#262626
endfunc

"---------------------------------------------------------------------------
" s:mod() abort: {{{3
" function of modified

func! s:mod() abort
  return (&mod)?'| + ':''
endfunc

"---------------------------------------------------------------------------
" s:ro() abort: {{{3
" function of read only

func! s:ro() abort
  return (&ro)?'| - ':''
endfunc

"---------------------------------------------------------------------------
" StlFenc() abort: {{{3
" function of fenc

func! StlFenc() abort
  let en = substitute(toupper(&fenc!=''?&fenc:&enc),'\M-','','g')
  if en =~? 'utf'
    let en .= &bomb ? 'B': 'N'
  endif
  return en
endfunc

"---------------------------------------------------------------------------
" s:RetError() abort: {{{3
" function to return erromsgs

func! s:RetError() abort
  return get(s:, 'lasterrormsg', '')
endfunc

"---------------------------------------------------------------------------
" s:stlupdate() abort: {{{3
" update stl in all window

func! s:stlupdate() abort
  let w = winnr()
  let s = winnr('$') == 1 ? [s:stl(0)] : [s:stl(0), s:stl(1)]
  for n in range(1, winnr('$'))
    call setwinvar(n, '&statusline', s[n!=w])
  endfor
endfunc

"---------------------------------------------------------------------------
" Commands: {{{2

"---------------------------------------------------------------------------
" :ShowError {{{3
" show last error

command! -nargs=0 ShowError echo s:RetError()

"---------------------------------------------------------------------------
" :GoError {{{3
" Go help file of last error

command! -nargs=0 GoError exe 'help' matchstr(s:RetError(),'\ME\d\+')

"---------------------------------------------------------------------------
" Au: {{{2

"---------------------------------------------------------------------------
" StlAu {{{3

aug StlAu
  au!
  au BufUnload * call s:stlupdate()
  au BufWinEnter * call s:stlupdate()
  au WinEnter * call s:stlupdate()
  au FileType * call s:stlupdate()
  au CursorMoved * call s:stlupdate()
aug END

"---------------------------------------------------------------------------
" Initialize: {{{2

call s:stlupdate()

"===========================================================================
" キーマップ: {{{1

"---------------------------------------------------------------------------
" 普通の奴ら: {{{2

"---------------------------------------------------------------------------
" ;と:の入れ変え: {{{3
" コマンドラインモードでは無効

nnoremap ;                  :<C-u>
nnoremap :                  ;
vnoremap ;                  :
vnoremap :                  ;
nnoremap q;                 q:
nnoremap q:                 q;

"---------------------------------------------------------------------------
" 挿入モードの時に<ESC>で挿入モードを抜けた時に自動的にIMEをオフに: {{{3

inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

"---------------------------------------------------------------------------
" ノーマルモードの時に<ESC><ESC>(<ESC>二回)で検索文字のハイライトを切り換え: {{{3

nnoremap <silent> <Esc><Esc> :<C-u>set nohlsearch!<CR>

"---------------------------------------------------------------------------
" 移動系で好み別れる所、詳しくは:help gjかgjの上でK(<S-k>): {{{3

nnoremap j                  gj
nnoremap k                  gk
nnoremap gj                 j
nnoremap gk                 k

"---------------------------------------------------------------------------
" <C-p>,<C-S-p>で連続貼り付け可能に: {{{3
" <C-p>はpと,<C-S-p>はP(<S-p>)と同様の動作

nnoremap <silent> <C-p>     "0p
nnoremap <silent> <C-S-p>   "0P
vnoremap <silent> <C-p>   "0p
vnoremap <silent> <C-S-p> "0P

"---------------------------------------------------------------------------
" <F1>で現在の.vimrcファイルの再読み込み: {{{3
" vimの設定変更が反映される

nnoremap <silent> <F1>               :<C-u>source $MYVIMRC<CR>
vnoremap <silent> <F1>               :<C-u>source $MYVIMRC<CR>

"---------------------------------------------------------------------------
" <F5>で現在のファイルの再読み込み: {{{3

nnoremap <silent> <F5>               :<C-u>silent! e!<CR>
vnoremap <silent> <F5>               :<C-u>silent! e!<CR>

"---------------------------------------------------------------------------
" <F12>で.vimrcを新規タブで編集: {{{3

nnoremap <silent> <F12>               :<C-u>tabe $MYVIMRC<CR>
vnoremap <silent> <F12>               :<C-u>tabe $MYVIMRC<CR>

"---------------------------------------------------------------------------
" windowsだとC-xに元から切り取りだか何だか糞なマップがされてるのでアンマップ: {{3
" 選択した範囲に数の増減(<C-a>,<C-x>)をやると、連番に出来る

if has('win32') || has('win64')
  try
    vunmap <C-X>
  catch
  endtry
endif

"---------------------------------------------------------------------------
" スペース + o + j/k で下/上に空白行を追加(カウント可能) {{{3

nmap     <Space>o           [BlankLine]
nnoremap <silent>           [BlankLine]j       :<C-u>for i in range(1, v:count1)<Bar>call append(line('.'),   '')<Bar>endfor<CR>
nnoremap <silent>           [BlankLine]k       :<C-u>for i in range(1, v:count1)<Bar>call append(line('.')-1, '')<Bar>endfor<CR>

" ターミナルでESCキーでノーマルモードにする {{{3
if exists(":tmap")
  if &termwinkey == ''
    tnoremap <Esc> <C-w><S-n>
  else
    exe 'tnoremap <Esc> '.&termwinkey.'<S-n>'
  endif
endif

"===========================================================================
" practice for vim: {{{1

"---------------------------------------------------------------------------
" Mapping: {{{2
" provide echo string mapping

"---------------------------------------------------------------------------
" s:rec(): {{{3
" start timer and stop timer if already exists

func! s:rec() abort
  if exists('s:n')
    call timer_stop(s:n)
  endif
  let s:n = timer_start(1000,function('<SID>wafun'),{'repeat':5})
  return
endfunc

"---------------------------------------------------------------------------
" s:wafun(...): {{{3
" echo s:wafuw

func! s:wafun(...) abort
  echo s:wafun
  let s:w = timer_start(400,function('<SID>wafuw'))
  return
endfunc

"---------------------------------------------------------------------------
" s:wafuw(...): {{{3
" echo s:wafun and s:wafuw

func! s:wafuw(...) abort
  echo s:wafuw
  return
endfunc

"---------------------------------------------------------------------------
" s:mapkey(k): {{{3
" map key of arg to s:rec()

func! s:mapkey(k) abort
  exe 'nnoremap <silent>' a:k ':<C-u>call <SID>rec()<CR>'
  exe 'vnoremap <silent>' a:k ':<C-u>call <SID>rec()<CR>'
  exe 'inoremap <silent>' a:k '<C-o>:<C-u>call <SID>rec()<CR>'
  return
endfunc

"---------------------------------------------------------------------------
" s:dontusethiskey(): {{{3
" mapping by using s:mapkey()

func! s:dontusethiskey() abort
  call s:mapkey('<Left>')
  call s:mapkey('<Down>')
  call s:mapkey('<Up>')
  call s:mapkey('<Right>')
  call s:mapkey('<PageUp>')
  call s:mapkey('<PageDown>')
  call s:mapkey('<Home>')
  call s:mapkey('<End>')
  call s:mapkey('<Insert>')
  call s:mapkey('<Del>')
  return
endfunc

"---------------------------------------------------------------------------
" Map: {{{3
" この関数呼び出しによってマッピングを行なっている

call s:dontusethiskey()

"---------------------------------------------------------------------------
" vim: set fdm=marker fmr={{{,}}} fdl=0 ts=8 sts=2 sw=2 tw=0 ft=vim :}}}
