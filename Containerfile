FROM registry.opensuse.org/opensuse/tumbleweed:latest

LABEL com.github.containers.toolbox="true"

RUN echo -e '[main]\nsolver.onlyRequires = true\nsolver.dupAllowVendorChange = false\nrpm.install.excludedocs = yes' > /etc/zypp/zypp.conf

RUN zypper modifyrepo --disable repo-non-oss
RUN zypper modifyrepo --disable repo-openh264
RUN zypper -n dist-upgrade
RUN zypper -n install -f bash bc command-not-found container-support-utils coreutils dash dash-sh diffutils glibc-locale htop less libcap-progs nano rpm shadow sudo system-group-wheel util-linux wget zsh zypper -bash-sh

RUN sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL$/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
RUN sed -i '/Defaults targetpw/d' /etc/sudoers

CMD /bin/sh
