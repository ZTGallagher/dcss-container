FROM python:2
LABEL maintainer="Zachary Gallagher"

ENV HOME /root
ENV LC_ALL C.UTF-8

RUN apt-get update && \
    apt-get -y install build-essential \
                       libncursesw5-dev \
                       bison \
                       flex \
                       liblua5.1-0-dev \
                       libsqlite3-dev \
                       libz-dev \
                       pkg-config \
                       python-yaml \
                       libsdl2-image-dev \
                       libsdl2-mixer-dev \
                       libsdl2-dev \
                       libfreetype6-dev \
                       libpng-dev \
                       ttf-dejavu-core \
                       ccache \
                       binutils-gold && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install tornado==3.2.2 pyyaml

WORKDIR /root
RUN git clone https://github.com/crawl/crawl
 
WORKDIR /root/crawl
RUN git config --global url."https://github".insteadOf git://github
RUN git submodule update --init

WORKDIR /root/crawl/crawl-ref/source
RUN make WEBTILES=y 

CMD python webserver/server.py
