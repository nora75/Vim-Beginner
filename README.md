# Overview

## Please note the following points

This file is make for my friend.  
This file provide settings for vim beginner and only support vim 8.0 or 8.1.  
This file has commentary of setting but written in Japanese.  

## How to Install

### First

#### dein.vim

```
call dein#add('NORA75/Itimura')
```

#### Neobundle.vim

```
Neobundle 'NORA75/Itimura'
```

### Second

#### Write this to your vimrc

**NOTE:**  
You have to source these setting commands before source this file.  

```
if has('vim_starting')
    if &enc !=# 'utf-8'
        set enc=utf-8
    endif

    if &fencs !=# 'ucs-bom,utf-8'
        set fileencodings=ucs-bom,utf-8
    endif

    if &fenc !=# 'utf-8'
        set fileencoding=utf-8
    endif
endif
```

# Description

## Mapping

+ swap ; and [normal/visual]

    + swap q; and q: too

+ map <Esc><Esc> (type <Esc> twice) to switch highlight on/off [normal]

+ swap all standard movment command and display lines downward [normal]

    + j and gj
    + k and gk

+ repeatable put mapping [normal/visual]

    + <C-p> put after cursor
    + <C-S-p> put before cursor

+ reload current vimrc file [normal/visual]

+ reload current file [normal/visual]

+ edit vimrc file in new tab [normal/visual]

+ append blank lines mapping [normal]

    this mapping supports count.  
    <Space>o and j/k.  
    <Space>oj to append under current cursor line.  
    <Space>ok to append above current cursor line.  

+ <Esc> to go to normal mode on terminal window [terminal]

    this command use &termwinkey.  
    Some versions do not work properly.  

+ unmap default <C-x> mapping when you use windows

### Mapping for Japanese

+ type <Esc> to reset IME status [insert]

### Mapping for practice vim

These keys are disabled because I recommend not to use these keys.  
The string *(>ω<)わふーっ！* is echoed on your vim when you type these keys.  
This string is Characters' lines.  

+ <Left>
+ <Down>
+ <Up>
+ <Right>
+ <PageUp>
+ <PageDown>
+ <Home>
+ <End>
+ <Insert>
+ <Del>

## Settings

### Settings for search

+ ignoracase
+ smartcase
+ wrapscan
+ hlsearch
+ incsarch

### Settings for edit file

+ set tabstop=8
+ set expandtab
+ set autoindent
+ set smartindent
+ set backspace=indent,eol,start
+ set showmatch
+ set wildmenu
+ set formatoptions+=mM
+ cllipboard share with system
+ set more
+ set history=100
+ set belloff=all
+ set whichwrap=b,s,h,l
+ set autoread
+ set modeline

### Settings for gui

+ guioprions

    don't show any scroll bar/menu bar/tool bar.  

+ guicursor don't blink
+ don't use mouse
+ maximize the window when start
+ syntax enale

### Settings for appearance

+ set number
+ set noruler
+ set nolist
+ set wrap
+ set laststatus=2
+ set cmdheight=2
+ set showcmd
+ set title
+ set linebreak
+ set showtabline=2
+ set equalalways
+ set cmdheight=2
+ set splitright

### Settings for japanese

+ iminsert=0 imsearch=0
+ highlight purple when IME on

### Settings for kaoriya

these setting is from kaoriya's vimrc.  
thanks a lot. 

+ disable Screen Mode plugin

    This plugin is usefull but the window get terrible when mistake to type or forget command.  

+ disable some kaoriya commands
+ set format exploer to the one supported Japanese
+ correspond auto wrap word in Japanese
+ prevent tag file dupricate
+ fix correspond move slow when $display is set
+ ambiwith/guifontset setting for gui

## Statusline

Provide my custom statusline.  

### Left contents

+ current dir
+ current file's dir
+ (>ω<)わふーっ!
+ current file's name
+ buffer is modified and isn't saved yet when displayed \+ mark
+ current file is read only when displayed RO mark

### Right contents

+ current file's extension
+ current file's charactor code (such as UTF8)
+ current file's Line feed code (such as CR/LF but displayed W(in)/U(nix)/M(ac))
+ the last searched or substituted string

# Misc

## Maintainer

NORA75  

## LICENSE

MIT

