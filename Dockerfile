# TODO: FPR: Consider an alpine image
# TODO: FPR: Add label describing intent of this image
FROM ubuntu:18.04

# Required to avoid interaction while doing apt udpate
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/app

# ffmpeg required to perform the raw PCM to wav conversion
RUN apt update && apt install -y autogen autoconf build-essential libtool libtool-bin ffmpeg

COPY . /usr/app

RUN ./autogen.sh && ./configure && make && make install

CMD ["./docker-entrypoint.sh"]