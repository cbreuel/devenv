FROM debian:stable-20200607

# Install basic packages and Vim dependencies
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get -y update && \
    apt-get install -y apt-utils && \
    apt-get install -y sudo && \
    apt-get install -y build-essential curl openssh-client && \
    apt-get install -y git && \
    apt-get install -y python3 && \
    apt-get install -y python3-pip && \
    apt-get install -y libncurses5-dev libatk1.0-dev \
                       libcairo2-dev libx11-dev libxpm-dev libxt-dev \
                       python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev && \
    rm -rf /var/lib/apt/lists/*

# Clone and build Vim
RUN git clone https://github.com/vim/vim.git && \
    cd vim && \
    ./configure --with-features=huge \
                --enable-multibyte \
                --enable-rubyinterp=yes \
                --enable-python3interp=yes \
                --with-python3-config-dir=$(python3-config --configdir) \
                --enable-perlinterp=yes \
                --enable-luainterp=yes \
                --disable-gui \
                --enable-cscope \
                --prefix=/usr/local && \
    make VIMRUNTIMEDIR=/usr/local/share/vim/vim82

# Install Vim
RUN cd vim && make install

