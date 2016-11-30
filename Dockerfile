# http://gernotklingler.com/blog/docker-replaced-virtual-machines-chroots/
FROM ubuntu:16.04
 
# ===== install/setup prerequisites =====
RUN apt-get update
 
# Use the "noninteractive" debconf frontend
ENV DEBIAN_FRONTEND noninteractive
 
RUN apt-get -y install sudo

# ===== add user =====
RUN useradd -ms /bin/bash weitang114
# default password: "pass"
RUN echo 'weitang114:pass' | chpasswd
RUN adduser weitang114 sudo
 
# ===== Install additional packages =====
RUN apt-get -y install git build-essential vim zsh tmux wget python2.7-dev python-pip


ENV HOME /home/weitang114/
ENV USER weitang114
USER weitang114

WORKDIR $HOME
# incstall oh-my-zsh, and ignore the harmless nonzero return code
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
#install Vundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

# dot files
RUN git clone https://github.com/weitang114/MyDotfiles $HOME/MyDotfiles
RUN ln -s $HOME/MyDotfiles/vimrc $HOME/.vimrc
RUN ln -s $HOME/MyDotfiles/tmux.conf $HOME/.tmux.conf
RUN rm $HOME/.zshrc
RUN ln -s $HOME/MyDotfiles/zshrc.basic $HOME/.zshrc

