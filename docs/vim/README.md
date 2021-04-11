# Vim

给文档从 https://github.com/mba811/mac-best-app/blob/master/Vim 而来，谢谢 mba811。

[.vimrc](https://github.com/tankywoo/linux-autoconfig/blob/master/.vimrc)

## 快捷键

### Movement

  * `h` - Move _left_
  * `j` - Move _down_
  * `k` - Move _up_
  * `l` - Move _right_
  * `0` - Move to _beginging_ of line, 也可以使用 `Home`.
  * `^` - 在有tab或space的代码行里, `0`是移到最行首, 而`^`是移到代码行首
  * `$` - Move to _end_ of line
  * `gg` - Move to _first_ line of file
  * `G` - Move to _last_ line of file
  * `ngg`- 移动到指定的第n行, 也可以用`nG`
  * `w` - Move _forward_ to next word
  * `b` - Move _backward_ to next word
  * `%` - 在匹配的括号、块的首尾移动
  * `C-o`- 返回到上次移动前的位置, 也可以用两个单引号`'`
  * `C-i`- 前进到后一次移动的位置
  * `f` - 后接字符，移动到当前行的下一个指定字符，然后按`;`继续搜索下一个
  * `F` - 同上，移动到上一个
  * `|` - 竖线，前接数字，移动到当前行的指定列，如`30|`，移动到当前行的第30列

### Search

  * `*` - Search _forward_ for word under cursor
  * `#` - Search _backward_ for word under curor
  * `/word` - Search _forward_ for _word_. Support _RE_
  * `?word` - Search _backward_ for _word_. Support _RE_
  * `n` - Repeat the last `/` or `?` command
  * `N` - Repeat the last `/` or `?` command in opposite direction

在搜索后, 被搜索的单词都会高亮, 一般想取消那些高亮的单词, 可以再次搜索随便输入一些字母, 搜索不到自然就取消了. 另外也可以使用 `nohl` 取消这些被高亮的词.

### Deletion

  * `x` - Delete character _forward_(under cursor), and remain in normal mode
  * `X` - Delete character _backward_(before cursor), and remain in normal mode
  * `r` - Replace single character under cursor, and remain in normal mode
  * `s` - Delete single character under cursor, and _switch_ to insert mode
  * `shift+~` - 这个可以把光标下的单词转换为大写/小写, 并自动移到下一个字符
  * `dw` - Delete a _word_ forward
  * `daw`- 上面的`dw`是删除一个单词的前向部分, 而这个是删除整个单词, 不论cursor是否在单词中间
  * `db` - Delete a _word_ backward
  * `dd` - Delete _entire_ current line
  * `D` - Delete until end of line

### Yank & Put

  * `y` - Yank(copy)
  * `yy` - Yank current line
  * `nyy` - Yank `n` lines form current line
  * `p` - Put(paste) yanked text _below_ current line
  * `P` - Put(paste) yanked text _above_ current line

### Insert Mode

  * `i` - Enter insert mode to the _left_ of the cursor
  * `a` - Enter insert mode to the _right_ of the cursor
  * `o` - Enter insert mode to the line _below_ the current line
  * `O` - Enter insert mode to the line _above_ the current line

### Visual Mode

  * `v` - Enter visual mode, highlight characters
  * `V` - Enter visual mode, highlight lines
  * `C-v` - Enter visual mode, highlight block

### Other

  * `u` - Undo
  * `U` - Undo all changes on current line
  * `C-r` - Redo

### Read More

  * [A handy guide to Vim shortcuts](http://eastcoastefx.vaesite.com/vim)
  * [tuxfiles-vimcheat](http://www.tuxfiles.org/linuxhelp/vimcheat.html)
  * [What is your most productive shortcut with Vim?](http://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim)

## 技巧

### shell多行注释

命令行模式下，注释掉line1与line2之间的行
    
    line1,line2s/^/#/g
    

### 自动补全
    
    Ctrl+n Ctrl+p
    Ctrl+x Ctrl+?{....}
    

### 左右分割打开help文档

默认是上下分割来打开文档，但是对于宽屏，左右分割反而更加方便
    
    :vert help xxx
    

### 逐个替换

全文直接替换:
    
    :%s/old_str/new_str/g
    

加上参数c可以逐个替换，这样可以对每一个再确认:
    
    :%s/old_str/new_str/gc
    

### 关于 search/replace 中的换行符

Search:

`\n` is `newline`, `\r` is `CR`(carriage return = Ctrl-M = ^M)

Replace:

`\r` is newline, `\n` is a null byte(0x00)

比如字符串 test1,test2,test3 把逗号换成换行：
    
    %s/,/\r/g
    

参考:

  * [How to replace a character for a newline in Vim?] (http://stackoverflow.com/questions/71323/how-to-replace-a-character-for-a-newline-in-vim)
  * [Why is \r a newline for Vim?](http://stackoverflow.com/questions/71417/why-is-r-a-newline-for-vim)
  * [How can I add a string to the end of each line in Vim?](http://stackoverflow.com/questions/594448/how-can-i-add-a-string-to-the-end-of-each-line-in-vim)
