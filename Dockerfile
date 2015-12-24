FROM python:latest

MAINTAINER Ron Kurr <kurr@kurron.org>

LABEL org.kurron.ide.name="Calibre" org.kurron.ide.version=2.47.0 

ENV DEBIAN_FRONTEND noninteractive

# Force Docker to use UTF-8 encodings
ENV LANG C.UTF-8

# Install the libraries needed to run a JVM in GUI mode
RUN apt-get update && \
    apt-get install -y libgtk2.0-0 libcanberra-gtk-module libxext-dev libxrender-dev libxtst-dev python-dev xdg-utils wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Install Python packages
#RUN pip install --upgrade pip pycrypto

# Create a user and group that matches what is in most Vagrant boxes
RUN groupadd --gid 1000 developer && \
    useradd --gid 1000 --uid 1000 --create-home --shell /bin/bash developer && \
    chown -R developer:developer /home/developer

# Set the environment to use the new user account
ENV HOME /home/developer

# the user of this image is expected to mount his actual home directory to this one
VOLUME ["/home/developer"]

ADD http://download.calibre-ebook.com/2.47.0/calibre-2.47.0-x86_64.txz /tmp/calibre-tarball.txz

RUN mkdir -p /opt/calibre && \
    rm -rf /opt/calibre/*  && \
    tar xvf /tmp/calibre-tarball.txz -C /opt/calibre && \
    /opt/calibre/calibre_postinstall

USER developer:developer
WORKDIR /home/developer
ENTRYPOINT ["/usr/bin/calibre","--with-library=/home/developer/ronbo"]
