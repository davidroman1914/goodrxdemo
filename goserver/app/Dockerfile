##################[GOLANG BUILD]##################
FROM golang:1.10 as builder

ARG PROTO_VERSION=v3.5.1
ARG PROTOC_ZIP=protoc-3.5.1-linux-x86_64.zip

RUN apt update -y && apt install tree unzip

# Set go bin which doesn't appear to be set already.
ENV GOBIN /go/bin

# build directories
ADD src/ /go/src/goserver/
WORKDIR /go/src/goserver

# Go dep! install dependencies
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
RUN dep init
RUN dep ensure

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /usr/local/bin/goserver .
CMD /usr/local/bin/goserver