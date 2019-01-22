#!/bin/bash
#
# File: uinstall.sh
# Author: Clare Lee[congleetea] <congleetea@gmail.com>
# Created: Monday, February 22 2016
#

set -e

# sudo apt-get update
THISDIR=$( cd "$( dirname "$0")" && pwd )
SWDIR=${THISDIR}/ubuntu_pkgs
CONFIGDIR=${THISDIR}/ubuntu_configs

EMACS_VER=25.2
GLOBAL_VER=6.5.7
ERLANG_VER=20.3
GOVERSION=1.10.3

init_sws=(terminator
          sougou
          shadowsocks
          vim
          trash-cli
          xclip
          valgrind
          zsh)

base_sws=(tree
          ssh
          openssl
          openssh-client
          openssh-server
          silversearcher-ag
          curl
          espeak
          shutter
          zathura
          calibre
          graphviz
          inkscape)

option_sws=(emacs
            ycmd
            erlang
            golang
            variety
            ansible)

function usage() {
    echo "usage: "
    echo "     install-ubuntu.sh init                 : install initial software in init_sws."
    echo "     install-ubuntu.sh base                 : install basic software in base_sws."
    echo "     install-ubuntu.sh option               : install optional software in option_sws."
    echo "     install-ubuntu.sh single SOFTWARE_NAME : install single software."
}

function echo_tip() {
    echo "******************* tip ************************"
    echo ">>>>>>  $1"
    echo "******************* tip ************************"
}

function interactive_install() {
    echo_tip "Please Note the interactive message>>>>> "
}

function install_deps() {
    for dep in $@
    do
    	echo "====> dep: $dep"
	sudo apt-get install -y $dep
    done
}

function install(){
    sws=$1
    sudo apt-get update
    for sw in ${sws[@]}
    do
        echo ""
        echo "===================================================="
        echo "================ install $sw "
        echo "===================================================="
        sleep 5
        if [ $sw == "git" ];then
            interactive_install
            sudo add-apt-repository ppa:git-core/ppa
            sudo apt-get update
            sudo apt-get install -y git
            sudo apt-get install -y meld
        elif [ $sw == "sougou" ];then
            interactive_install
            sudo apt-get install -y fcitx libssh2-1
            # cd ${SWDIR} && wget "http://pinyin.sogou.com/linux/download.php?f=linux&bit=64" -O "sougou_64.deb"
            cd ${SWDIR} && sudo dpkg -i sougou_64.deb
        elif [ $sw == "zsh" ];then
            if [ ! -d "/home/$USER/.oh-my-zsh" ];then
                git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
            fi
            sudo apt-get install -y zsh
            chsh -s /bin/zsh

            if [ ! -d "/home/$USER/autojump" ];then
            	git clone https://github.com/joelthelion/autojump.git ~/autojump
	    fi
            cd ~/autojump && ./install.py
            # echo "[[ -s /home/${USER}/.autojump/etc/profile.d/autojump.sh ]] && source /home/${USER}/.autojump/etc/profile.d/autojump.sh" >> ~/.zshrc
            rm -rf ~/autojump

            if [ ! -d "/home/$USER/.fzf" ];then
            	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            fi
            ~/.fzf/install
            source ~/.zshrc
        elif [ $sw == "emacs" ];then
            if [ ! -f ${SWDIR}/emacs-${EMACS_VER}.tar.gz ];then
                cd ${SWDIR} && wget http://mirrors.ustc.edu.cn/gnu/emacs/emacs-${EMACS_VER}.tar.gz
            fi
            cd ${SWDIR} && tar xvf emacs-${EMACS_VER}.tar.gz && cd emacs-${EMACS_VER} && ./configure && make && sudo make install
            cd ${SWDIR} && rm -rf emacs-${EMACS_VER}
            sudo apt-get install -y exuberant-ctags
            install_deps build-essential texinfo libx11-dev libxpm-dev libgif-dev
            install_deps openjdk-8-jdk libxaw7-dev libjpeg-dev libpng12-dev libtiff5-dev libncurses5-dev xsel libclang-3.8-dev
            install_deps texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-xetex # for org exported to pdf.
            if [ ! -f ${SWDIR}/global-${GLOBAL_VER}.tar.gz ];then
                cd ${SWDIR} && wget ftp://ftp.gnu.org/pub/gnu/global/global-${GLOBAL_VER}.tar.gz
            fi
            cd ${SWDIR} && tar xvf global-${GLOBAL_VER}.tar.gz && cd global-${GLOBAL_VER} && ./configure && make && sudo make install
            # echo "export GTAGSCONF=/usr/local/share/gtags/gtags.conf" >> ~/.zshrc
            # echo "export GTAGSLABEL=ctags gtags" >> ~/.zshrc
            cd ${SWDIR} && rm -rf global-${GLOBAL_VER}
        elif [ $sw == "ycmd" ];then
            if [ ! -d "${THISDIR}/emacs.d/vendor/ycmd" ];then
                cd ${THISDIR}/emacs.d/vendor && git clone https://github.com/Valloric/ycmd.git
            fi
            if [ ! -d "${THISDIR}/emacs.d/vendor/YCM-Generator" ];then
                cd ${THISDIR}/emacs.d/vendor && git clone https://github.com/rdnetto/YCM-Generator.git
            fi
            install_deps libclang-3.8-dev clang-3.8
            sudo ln -s /usr/bin/clang-3.8 /usr/bin/clang
            sudo ln -s /usr/bin/clang++-3.8 /usr/bin/clang++
            cd ${THISDIR}/emacs.d/vendor/ycmd && git submodule update --init --recursive
            cd ${THISDIR}/emacs.d/vendor/ycmd && ./build.py --clang-completer --system-libclang

            echo "Now you can execute command: ycmd in your project to generate .ycm_extra_conf.py, then enjoy it."
        elif [ $sw == "erlang" ]; then
            cd ${SWDIR}
            # wget http://erlang.org/download/otp_src_$ERLANG_VER.tar.gz
            # wget http://erlang.org/download/otp_doc_man_$ERLANG_VER.tar.gz
            tar xvf otp_src_$ERLANG_VER.tar.gz
            install_deps build-essential autoconf m4 libncurses5-dev \
                 libgl1-mesa-dev libglu1-mesa-dev libpng3 libssh-dev unixodbc-dev
            cd otp_src_$ERLANG_VER && ./configure && make && sudo make install
            cd ${SWDIR}
            tar xvf otp_doc_man_$ERLANG_VER.tar.gz
            # sudo cp -r man /usr/local/lib/erlang/

            # sudo apt-get install -y rlwrap  # 可以用以erlang的历史命令记录。
            # 在zshrc中添加：alias erl='/usr/bin/rlwrap -a erl'
        elif [ $sw == "golang" ]; then
            GOTO=/usr/local
            GOROOT=${GOTO}/go
            GOPATH=/home/${USER}/gitlab/go
            if [ ! -d ${GOROOT} ]; then
                sudo rm ${GOROOT} -rf
            fi
            if [ ! -d ${GOPATH} ]; then
                mkdir -p ${GOPATH}
            fi
            sudo tar -C /usr/local -xzf ${SWDIR}/go${GOVERSION}.linux-amd64.tar.gz
            echo "export GOROOT=${GOROOT}" >> ~/.zshrc
            echo "export GOPATH=${GOPATH}" >> ~/.zshrc
            echo "export PATH=\$PATH:${GOROOT}/bin:${GOPATH}/bin" >> ~/.zshrc
            echo "GOPATH: $GOPATH"
            source ~/.zshrc
            go get github.com/rogpeppe/godef
            go get github.com/nsf/gocode
	    go get -u golang.org/x/tools/cmd/goimports
        elif [ $sw == "shadowsocks" ]; then
            sudo apt-get install -y inkscape
            # instalation for shadowsocks in terminator
            # http://droidyue.com/blog/2016/04/04/set-shadowsocks-proxy-for-terminal/index.html
            sudo apt-get install -y python-pip
            sudo pip install --upgrade git+https://github.com/shadowsocks/shadowsocks.git@master
	    cd ${SWDIR} && tar xvf libsodium.tar.gz && cd libsodium-stable && ./configure --prefix=/usr && make && sudo make install
            sudo apt-get install -y polipo
            sudo cp ${CONFIGDIR}/polipo.conf /etc/polipo/config
            sudo service polipo stop
            sudo service polipo start
        elif [ $sw == "variety" ]; then
            # an automatic wallpaper changer, downloader and manager.
            sudo add-apt-repository ppa:peterlevi/ppa
            sudo apt-get update
            sudo apt-get install variety
        elif [ $sw == "ansible" ]; then
            sudo apt-get install -y software-properties-common
            sudo apt-add-repository ppa:ansible/ansible
            sudo apt-get update
            sudo apt-get install -y ansible
        elif [ $sw == "pdfeditor" ]; then
            if [ ! -f ${SWDIR}/master-pdf-editor-4.0.10_qt5.amd64.deb ]; then
                cd ${SWDIR} && wget http://get.code-industry.net/public/master-pdf-editor-4.0.10_qt5.amd64.deb
            fi
            cd ${SWDIR} && sudo dpkg -i master-pdf-editor-4.0.10_qt5.amd64.deb
        else
            sudo apt-get install -y $sw
        fi
    done
}

if [ $1 == "init" ];then
    install "${init_sws[*]}"
elif [ $1 == "base" ]; then
    install "${base_sws[*]}"
elif [ $1 == "option" ]; then
    install "${option_sws[*]}"
elif [ $1 == "single" ]; then
    single=($2)
    install "${single[*]}"
else
    usage
fi
