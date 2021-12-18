FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt -y dist-upgrade
RUN apt -y install python3-pip locales libldap2-dev libsasl2-dev zlib1g-dev libjpeg-dev

# Locale related
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD . /mezzanine
WORKDIR /mezzanine
RUN pip3 install -r trehacklab/requirements.txt

ENTRYPOINT bash -c "cd trehacklab && python3 manage.py migrate && python3 manage.py collectstatic --noinput && python3 -u manage.py runserver 0.0.0.0:8000 --noreload"
