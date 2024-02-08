FROM registry.opensuse.org/opensuse/tumbleweed:latest

LABEL com.github.containers.toolbox="true"

RUN echo -e '[main]\nsolver.onlyRequires = true\nsolver.dupAllowVendorChange = false\nrpm.install.excludedocs = no' > /etc/zypp/zypp.conf

RUN zypper addlock flatpak plymouth podman systemd
RUN zypper modifyrepo --disable repo-non-oss
RUN zypper modifyrepo --disable repo-openh264
RUN zypper -n dist-upgrade
RUN zypper -n install -f container-support-utils curl dash dash-sh glibc-locale htop iproute2 iputils libcap-progs macchina nano openssh-clients shadow sudo system-group-wheel util-linux zsh -bash-sh

RUN sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL$/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /usr/etc/sudoers
RUN sed -i '/Defaults targetpw/d' /usr/etc/sudoers

RUN curl -L -o /usr/bin/host-spawn https://github.com/1player/host-spawn/releases/download/1.5.0/host-spawn-$(uname -m)
RUN chmod +x /usr/bin/host-spawn
COPY host-runner.sh /usr/local/bin/host-runner.sh
RUN chmod +x /usr/local/bin/host-runner.sh

RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/flatpak
RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/nautilus
RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/podman
RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/rpm-ostree
RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/systemctl
RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/uname-host
RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/xdg-open
RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/zsh-host

CMD /bin/sh
