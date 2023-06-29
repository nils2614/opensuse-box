FROM registry.opensuse.org/opensuse/tumbleweed:latest

LABEL com.github.containers.toolbox="true"

RUN echo -e '[main]\nsolver.onlyRequires = true\nsolver.dupAllowVendorChange = false\nrpm.install.excludedocs = yes' > /etc/zypp/zypp.conf

RUN zypper modifyrepo --disable repo-non-oss
RUN zypper -n dist-upgrade
RUN zypper -n install -f bash command-not-found container-support-utils coreutils dash dash-sh glibc-locale htop libcap-progs nano rpm sudo system-group-wheel util-linux wget zsh zypper -bash-sh

RUN sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL$/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
RUN sed -i '/Defaults targetpw/d' /etc/sudoers

CMD /bin/sh
