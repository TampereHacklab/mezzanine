FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive

# Workaround for bug in debian - remove when possible!
RUN mkdir -p /usr/share/man/man1
RUN touch /usr/share/man/man1/sh.distrib.1.gz
# end workaround

RUN apt update
RUN apt -y dist-upgrade
RUN apt -y install python3-pip locales libldap2-dev libsasl2-dev

# Locale related
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD . /mezzanine
WORKDIR /mezzanine
RUN pip3 install -r trehacklab/requirements.txt

CMD sleep 999d

