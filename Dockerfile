FROM fedora:38
ENV TZ 'Europe/Moscow'
ARG USER
RUN useradd --create-home --shell /bin/bash $USER
ARG TARGETPLATFORM
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
        https://github.com/fb929/xc/releases/download/v0.0.5/xc-0.0.5-1.${ARCH}.rpm \
        python3-pyyaml \
        openvpn
# terraform {{
RUN dnf install -y dnf-plugins-core
RUN dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
RUN dnf -y install terraform
# }}
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USER
WORKDIR /home/$USER
