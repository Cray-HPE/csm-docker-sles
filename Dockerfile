# MIT License
#
# (C) Copyright [2021-2022] Hewlett Packard Enterprise Development LP
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
FROM  artifactory.algol60.net/csm-docker/stable/docker.io/opensuse/leap:15.2 as base

ARG user=jenkins
ARG group=jenkins
ARG uid=10000
ARG gid=10000

ENV HOME /home/${user}
RUN groupadd -g ${gid} ${group} && useradd -l -c "Jenkins USER" -d $HOME -u ${uid} -g ${gid} -m ${user}

RUN sed -i -E "s/^.*(rpm\.install\.excludedocs).*/\1 = yes/" /etc/zypp/zypp.conf

CMD ["/bin/bash"]
FROM base as product

RUN zypper --gpg-auto-import-keys refresh \
    && zypper --non-interactive install --no-recommends --force-resolution \
        autoconf \
        automake \
        binutils \
        binutils-devel \
        binutils-gold \
        createrepo_c \
        curl \
        docker \
        gcc \
        gcc-c++ \
        gdbm-devel \
        git \
        jq \
        libcurl-devel \
        libopenssl-devel \
        libpcap-devel \
        libtool \
        make \
        ncurses-devel \
        openssl \
        pam-devel \
        readline-devel \
        rpm-build \
        rpmlint \
        rsync \
        skopeo \
        sqlite3-devel \
        sudo \
        unzip \
        util-linux \
        vim \
        wget \
        which \
        xz-devel \
        zlib-devel \
        && zypper clean -a

WORKDIR /build
