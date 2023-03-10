FROM ubuntu:20.04
LABEL org.opencontainers.image.source https://github.com/geomagical/gke-puppeteer-webgl

ADD https://deb.nodesource.com/setup_18.x /nodesource_setup.sh
RUN \
  bash /nodesource_setup.sh && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    pkg-config \
    xorg \
    xserver-xorg \
    libx11-dev \
    libxext-dev \
    libnss3 \
    libasound2 \
    nodejs && \
  rm -rf /var/lib/apt/lists
COPY xorg.conf /etc/X11/xorg.conf
COPY run.sh /run.sh

ENV PATH "/usr/local/nvidia/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV DISPLAY ":0"
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib64

ENTRYPOINT ["bash", "/run.sh"]
