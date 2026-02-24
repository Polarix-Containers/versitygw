ARG UID=200020
ARG GID=200020

FROM versity/versitygw:latest

ARG UID
ARG GID

LABEL maintainer="Thien Tran contact@tommytran.io"

RUN apk -U upgrade \
    && apk add libstdc++ \
    && rm -rf /var/cache/apk/*

RUN --network=none \
  addgroup -g ${GID} versitygw \
  && adduser -u ${UID} --ingroup versitygw --disabled-password --system versitygw

COPY --from=ghcr.io/polarix-containers/hardened_malloc:latest /install /usr/local/lib/
ENV LD_PRELOAD="/usr/local/lib/libhardened_malloc.so"

USER versitygw