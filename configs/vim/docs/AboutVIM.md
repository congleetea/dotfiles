如何安装VIM插件
==========================

虽然 [Vim](https://link.zhihu.com/?target=https%3A//www.vim.org/) 是快速且高效的，但在默认情况下，它仅仅只是一个文本编辑器。至少，这就是没有插件的情况 Vim 应当具备的样子，插件构建在 Vim 之上，并添加额外的功能，使 Vim 不仅仅是一个输入文本的窗口。有了合适的插件组合，你可以控制你的生活，形成你自己独特的 Vim 体验。你可以[自定义你的主题](https://link.zhihu.com/?target=https%3A//opensource.com/article/19/12/colors-themes-vim)，你可以添加语法高亮，代码 linting，版本跟踪器等等。

## 怎么安装 Vim 插件

Vim 可以通过插件进行扩展，但很长一段时间以来，并没有官方的安装方式去安装这些插件。从 Vim 8 开始，有一个关于插件如何安装和加载的结构。你可能会在网上或项目自述文件中遇到旧的说明，但只要你运行 Vim 8 或更高版本，你应该根据 Vim 的[官方插件安装方法](https://link.zhihu.com/?target=https%3A//github.com/vim/vim/blob/03c3bd9fd094c1aede2e8fe3ad8fd25b9f033053/runtime/doc/repeat.txt%23L515)安装或使用 Vim 包管理器。你可以使用包管理器，无论你运行的是什么版本（包括比 8.x 更老的版本），这使得安装过程比你自己维护更新更容易。

## 使用VIM包管理器

自从 Vim 8 以后，包管理器变得不那么有用了，但是一些用户仍然喜欢它们，因为它们能够自动更新一些插件。有几个包管理器可供选择，并且它们各不相同，但是 [vim-plug](https://link.zhihu.com/?target=https%3A//github.com/junegunn/vim-plug) 有一些很棒的特性和最好的文档，这使我们很容易开始并在以后深入研究。

**使用 vim-plug 安装插件**

安装 vim-plug，以便它在启动时自动加载：

```text
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

创建一个 `~/.vimrc` 文件（如果你还没有这个文件），然后输入以下文本：

```text
call plug#begin()
Plug 'preservim/NERDTree'
call plug#end()
```

每次要安装插件时，都必须在 `plug＃begin()` 和 `plug＃end()` 之间输入插件的名称和位置（上面以 NERDTree 文件管理器为例）。如果你所需的插件未托管在 GitHub 上，你可以提供完整的 URL，而不仅仅是 GitHub 的用户名和项目 ID。你甚至可以在 `~/.vim` 目录之外“安装”本地插件。

最后，启动 Vim 并提示 vim-plug 安装 `~/.vimrc` 中列出的插件：

```text
:PlugInstall
```

等待插件下载。

**通过 vim-plug 更新插件**

与手动安装过程相比，编辑 `~/.vimrc` 并使用命令来进行安装可能看起来并没有多省事，但是 vim-plug 的真正优势在更新。更新所有安装的插件，使用这个 Vim 命令:

```text
:PlugUpdate
```

如果你不想更新所有的插件，你可以通过添加插件的名字来更新任何插件:

```text
:PlugUpdate NERDTree
```

**恢复插件**

vim-plug 的另一个优点是它的导出和恢复功能。Vim 用户都知道，正是插件的缘故，通常每个用户使用 Vim 的工作方式都是独一无二的。一旦你安装和配置了正确的插件组合，你最不想要的局面就是再也找不到它们。

Vim-plug 有这个命令来生成一个脚本来恢复所有当前的插件:

```text
:PlugSnapshot ~/vim-plug.list
```

vim-plug 还有许多其他的功能，所以请参考它的[项目页面](https://link.zhihu.com/?target=https%3A//github.com/junegunn/vim-plug)以获得完整的文档。

## 打造一个完美的 Vim

当你整天都在做一个项目时，你希望每一个小细节都能为你提供最好的服务。了解 Vim 和它的许多插件，直到你为你所做的事情构建出一个完美的应用程序。

