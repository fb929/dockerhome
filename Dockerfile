FROM fedora:38
ARG USER
RUN useradd --create-home --shell /bin/bash $USER
RUN yum install -y glibc-langpack-en hostname git perl which procps-ng wget rsync gpg e2fsprogs cryptsetup screen vim-enhanced pinentry whois bind-utils iputils
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USER
WORKDIR /home/$USER
