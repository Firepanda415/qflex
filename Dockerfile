# Base OS
FROM alpine:latest

# Install dependencies
RUN apk update
RUN apk add g++ make gsl-dev git autoconf automake python3-dev py3-pybind11 py3-packaging py3-pytest

# Copy qflex
COPY ./ /qflex/

WORKDIR /qflex/

# Install dependences
RUN autoreconf -i && autoconf && ./configure --disable-cirq

# Compile qflex
RUN make -j${OMP_NUM_THREADS}

ENTRYPOINT ["/qflex/src/qflex.x"]
