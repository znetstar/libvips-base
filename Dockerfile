FROM ubuntu:20.04

ARG CORES=1
ARG VIPSBRANCH=master
ENV VIPSHOME /opt/vips
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -o Dpkg::Options::="--force-confold"  -y imagemagick \
      libvips-dev \
      build-essential \
      libvips-tools \
      python3-gi \
      gir1.2-vips-8.0 \
      git  \
      gobject-introspection  \
      libjpeg-dev  \
      libpng-dev \
      libexif-dev \
      librsvg2-dev \
      libpoppler-glib-dev \
      libpng-dev \
      libwebp-dev \
      libopenexr-dev \
      libheif-dev \
      libtiff-dev \
      gtk-doc-tools && \
    git clone -b $VIPSBRANCH --depth 1 git://github.com/jcupitt/libvips.git /usr/local/src/vips && \
    cd /usr/local/src/vips && \
    ./autogen.sh --prefix=$VIPSHOME && \
    make -j $CORES && \
    make install  && \
    ldconfig && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    cp -r /opt/vips /usr/local
