ARG debian_buster_image_tag=12-slim
FROM debian:${debian_buster_image_tag}

# -- Layer: OS + Python 3.12

ARG shared_workspace=/opt/workspace

RUN mkdir -p ${shared_workspace} && \
    apt-get update -y && \
    apt install -y curl gcc &&\ 
    apt install -y build-essential zlib1g-dev libncurses5-dev && \
    apt install -y libsqlite3-dev && \
    apt install -y libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget libjpeg-dev && \
    apt install -y default-jdk &&\
    curl -O https://www.python.org/ftp/python/3.12.6/Python-3.12.6.tar.xz  && \
    tar -xf Python-3.12.6.tar.xz && cd Python-3.12.6 && ./configure && make -j 8 &&\
    make install && \
    apt-get update && apt-get install -y procps && apt-get install -y vim && apt-get install -y net-tools && \
    rm -rf /var/lib/apt/lists/*

ENV SHARED_WORKSPACE=${shared_workspace}

# -- Runtime

VOLUME ${shared_workspace}
CMD ["bash"]