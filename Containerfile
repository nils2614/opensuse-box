FROM registry.opensuse.org/opensuse/tumbleweed:latest

LABEL com.github.containers.toolbox="true"

RUN echo -e '[main]\nsolver.onlyRequires = true\nsolver.dupAllowVendorChange = false\nrpm.install.excludedocs = yes' > /etc/zypp/zypp.conf

RUN zypper modifyrepo --disable repo-non-oss
RUN zypper modifyrepo --disable repo-openh264
RUN zypper -n dist-upgrade
RUN zypper -n install -f bash container-support-utils dash dash-sh flatpak-spawn glibc-locale htop libcap-progs nano shadow sudo system-group-wheel util-linux wget zsh -bash-sh

RUN sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL$/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
RUN sed -i '/Defaults targetpw/d' /etc/sudoers

COPY host-runner.sh /usr/local/bin/host-runner.sh
RUN chmod +x /usr/local/bin/host-runner.sh
RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/flatpak
RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/nautilus
RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/podman
RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/rpm-ostree
RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/systemctl
RUN ln -sf /usr/local/bin/host-runner.sh /usr/local/bin/xdg-open

CMD /bin/sh
