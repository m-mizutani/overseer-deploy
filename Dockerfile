FROM ghcr.io/m-mizutani/overseer:cfac89937702a42da956bb25e42580a85c64ff79

COPY queries /queries
WORKDIR /

ENV OVERSEER_QUERY_DIR=/queries
ENV OVERSEER_LOG_FORMAT=json
ENTRYPOINT ["/overseer", "run"]
