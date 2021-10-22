FROM ubuntu:20.04

ARG CORES=1

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
    git clone git://github.com/jcupitt/libvips.git /opt/libvips && \
    cd /opt/libvips && \
    ./autogen.sh && \
    make -j $CORES && \
    make install  && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*
