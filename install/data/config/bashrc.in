# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
alias c="clear"
# alias e="LC_CTYPE=zh_CN.UTF-8 emacs &"
alias e="emacs -nw"
alias gst="git status"
alias gad="git add"
alias gbr="git branch -vv"
alias gcl="git clone"
alias gps="git push"
alias gpl="git pull"
alias gplumr="git pull upstream master --rebase"
alias gcm="git commit -m"
alias gdf="git diff"
alias glg="git log --graph"
alias grh="git reset --hard"
alias gsh="git show "
alias gmg="git merge --no-ff"
alias aptinstall="sudo apt-get install "
alias aptshow="sudo apt show "
alias ninstall="sudo npm install -g"
alias pinstall="sudo pip install"
alias ot="nautilus"
alias ycmd="/home/${USER}/gitlab/dotfiles/emacs.d/vendor/YCM-Generator/config_gen.py ./"
alias sbsh="source ~/.bashrc"
alias dl="cd ~/Downloads"
alias dc="cd ~/Documents"
alias dt="cd ~/Desktop"
alias say="espeak"
alias mj="make -j4"
function mkcd() { mkdir -p "$@" && cd "$_"; }
# function seddir() { sed -i "s/$1/$2/g" `grep $1 -rl ./` }

# usage: cd your_project && ginit yourname youremail
function ginit() {
    if [ -z $1 -a -z $2 ];then
        echo "USAGE: "
        echo "     cd your_project"
        echo "     ginit yourname your@email.com"
    else
        echo "[user]" >> .git/config
        echo "     name  = $1" >> .git/config
        echo "     email = $2" >> .git/config
        echo "GPATH\nGRTAGS\nGTAGS" >> .gitignore
    fi
}

function cm() {
  nowdir=$PWD
  cd /home/$USER/gitlab/catkin_ws && catkin_make -j4 && cd $nowdir
}

function gstyle() {
  astyle --options=/home/$USER/gitlab/dotfiles/configs/astylerc --preserve-date $* 
}

function cpwd() {
    pwd | xclip -selection clipboard
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[[ -s /home/congleetea/.autojump/etc/profile.d/autojump.sh ]] && source /home/congleetea/.autojump/etc/profile.d/autojump.sh
export ROS_WORKSPACE=~/gitlab/catkin_ws/src
[ -f /opt/ros/kinetic/setup.bash ] && source /opt/ros/kinetic/setup.bash
[ -f ~/gitlab/catkin_ws/devel/setup.bash ] && source ~/gitlab/catkin_ws/devel/setup.bash
function git-branch-name {
  git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3
}
function git-branch-prompt {
  local branch=`git-branch-name`
  if [ $branch ]; then printf " [%s]" $branch; fi
}
PS1="\u@\h \[\033[0;36m\]\W\[\033[0m\]\[\033[0;32m\]\$(git-branch-prompt)\[\033[0m\] \$ "
alias rm="trash"

export ROS_IP=192.168.1.100
export ROS_MASTER_URI=http://192.168.1.2:11311
