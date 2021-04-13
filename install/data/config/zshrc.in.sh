##########################################################################################
#ln -s /home/$USER/dotfiles/zshrc /home/$USER/.zshrc   # 使用绝对路径进行软链接#
##########################################################################################

alias rm="trash"
unalias rm
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-flow-avh autojump)

# User configuration

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#########################################################


export GTAGSCONF=/usr/local/share/gtags/gtags.conf
export GTAGSLABEL=ctags gtags

export NVM_DIR="/home/${USER}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


setxkbmap -option ctrl:swapcaps

export GOROOT=/usr/local/go
export GOPATH=/home/${USER}/gitlab/go
export PATH=$PATH:/usr/local/go/bin:/home/${USER}/gitlab/go/bin

#########################################################
LC_TIME=en_US.UTF-8
alias c="clear"
alias emacs="LC_CTYPE=zh_CN.UTF-8 emacs "
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
alias ott="nautilus ."
alias ycmd="${HOME}/gitlab/dotfiles/emacs.d/vendor/YCM-Generator/config_gen.py ./"
alias szsh="source ~/.zshrc"
alias dl="cd ~/Downloads"
alias dc="cd ~/Documents"
alias dt="cd ~/Desktop"
alias say="espeak"
alias mj="make -j4"

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }
function seddir() { sed -i "s/$1/$2/g" `grep $1 -rl ./` }
function jws() { cd ~/gitlab/catkin_ws/src }
function mssh() { ssh -p 22 muyuan@$1 }
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

alias cb="catkin build"
alias catkin_changelog="catkin_generate_changelog --skip-merges"
function cm() {
  nowdir=$PWD
  {
    cd /home/$USER/gitlab/catkin_ws && catkin_make -j8
    cd $nowdir
  } || {
    cd $nowdir
  }
}

function gstyle() {
  astyle --options=/home/$USER/gitlab/dotfiles/configs/astylerc --preserve-date $*
}

function cpwd() {
    pwd | xclip -selection clipboard
}

function proxy() {
	export http_proxy="127.0.0.1:2340"
	export https_proxy="127.0.0.1:2340"
}

function noproxy() {
	unset http_proxy
	unset https_proxy
}

alias aptversion="apt-cache madison "
alias unzip="unzip -O CP936 "
alias sshi="ssh-keygen -f $HOME/.ssh/known_hosts -R 192.168.1.2 && ssh "
alias tow="cd /media/congleetea/OS/Users/congl/Documents"

if [ -f /usr/share/autojump/autojump.zsh ];then
	source /usr/share/autojump/autojump.zsh
fi

##　For ROS
export ROS_WORKSPACE=~/gitlab/catkin_ws/src
if [ -f /opt/ros/noetic/setup.zsh ];then
	source /opt/ros/noetic/setup.zsh
fi

if [ -f ~/gitlab/catkin_ws/devel/setup.zsh ];then
	source ~/gitlab/catkin_ws/devel/setup.zsh
fi
# source /home/muyuan/muyuanros/ros_app/setup.zsh
# export ROS_IP=192.168.1.159
# export ROS_MASTER_URI=http://192.168.1.2:11311

## For Golang
export GOROOT=/usr/local/go
export GOPATH=$HOME/gitlab/go
export PATH=$PATH:/usr/local/go/bin:$HOME/gitlab/go/bin


################################# end ########################
alias rm="trash"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
