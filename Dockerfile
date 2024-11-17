FROM ubuntu:22.04 AS build

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    git

WORKDIR /home/tibasic

RUN git clone --depth=1 https://github.com/miselin/tibasic.git .

RUN mkdir build && cd build && \
    cmake .. && make


FROM ubuntu:22.04

COPY --from=build /home/tibasic/build/src/tibasic /usr/bin
COPY --from=build /home/tibasic/build/src/libinternals.a /usr/lib
