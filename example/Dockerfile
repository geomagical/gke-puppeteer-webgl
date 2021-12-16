FROM ghcr.io/geomagical/gke-puppeteer-webgl
LABEL org.opencontainers.image.source https://github.com/geomagical/gke-puppeteer-webgl

COPY . /src
WORKDIR /src
RUN npm install
CMD ["npm", "start"]
