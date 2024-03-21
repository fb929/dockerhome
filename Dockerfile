FROM fedora:38
ENV TZ 'Europe/Moscow'
ARG USER
RUN useradd --create-home --shell /bin/bash --password '$y$j9T$YDcWiJnid5kaqNfIkyyhb/$ef2BLaDOTrFuCxJz96A0KIowyi26.o7ySiLuJApcke3' $USER
ARG TARGETPLATFORM
ARG XC_VERSION=0.0.6
ARG RSH_VERSION=0.0.7
RUN case ${TARGETPLATFORM} in \
         "linux/amd64") ARCH=x86_64;; \
         "linux/arm64") ARCH=aarch64;; \
         *) ARCH=unknown;; \
    esac \
    && yum install -y \
        glibc-langpack-en \
        hostname \
        git \
        perl \
        which \
        procps-ng \
        wget \
        rsync \
        gpg \
        e2fsprogs \
        cryptsetup \
        screen \
        vim-enhanced \
        pinentry \
        whois \
        bind-utils \
        iputils \
        iproute \
        telnet \
        awscli \
        traceroute \
        https://github.com/fb929/xc/releases/download/v${XC_VERSION}/xc-${XC_VERSION}-1.${ARCH}.rpm \
        python3-pyyaml \
        openvpn \
        lsof \
        python3-pexpect \
        python3-gnupg \
        python3-pip \
        python3-ovh \
        https://github.com/fb929/rsh/releases/download/v${RSH_VERSION}/rsh-${RSH_VERSION}-1.noarch.rpm \
        jq \
        python3-devel \
    && echo
# terraform {{
RUN dnf install -y dnf-plugins-core
RUN dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
RUN dnf -y install terraform
# }}
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USER
WORKDIR /home/$USER
