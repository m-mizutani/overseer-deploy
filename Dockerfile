FROM ghcr.io/goccy/bigquery-emulator:latest as bigquery-emulator

FROM ghcr.io/m-mizutani/overseer:fd1efa7bf6d6e4a66fc182bc290f9cf7d5d8c8ac

COPY --from=bigquery-emulator /bin/bigquery-emulator /bigquery-emulator
COPY queries /queries
WORKDIR /

ENV OVERSEER_QUERY_DIR=/queries
ENV OVERSEER_LOG_FORMAT=json
ENV OVERSEER_EMULATOR_PATH=/bigquery-emulator
ENTRYPOINT ["/overseer"]
