FROM debian:buster-slim
ENV DEBIAN_FRONTEND noninteractive

RUN apt update
# disabled due to bug in dash
#RUN apt -y dist-upgrade
RUN apt -y install virtualenv python3-pip locales

# Locale related
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD . /mezzanine
WORKDIR /mezzanine
RUN virtualenv -p python3 virtualenv
RUN /bin/bash -c "source virtualenv/bin/activate && \
  cd trehacklab && \
  pip3 install -r requirements.txt"

CMD sleep 999d

