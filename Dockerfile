ARG BUILD_FROM
FROM $BUILD_FROM
FROM python:3.8-slim

# Install requirements for add-on
RUN \
  apk add --no-cache \
    example_alpine_package

# Copy data for add-on
COPY run.sh /

RUN pip install --no-cache-dir --progress-bar off -r requirements.txt
RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy \
    inetutils-ping \
  && rm -rf /var/lib/apt/lists/*
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

LABEL \
  io.hass.version="VERSION" \
  io.hass.type="addon" \
  io.hass.arch="armhf|aarch64|i386|amd64"
