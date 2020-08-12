FROM tensorflow/tensorflow:latest
RUN mkdir /tools /apps
WORKDIR /tools

RUN apt-get -y install git vim wget

RUN wget https://golang.org/dl/go1.15.linux-amd64.tar.gz
RUN tar -C /usr/local  -xzf go1.15.linux-amd64.tar.gz
RUN export PATH=$PATH:/usr/local/go/bin

RUN wget https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-2.3.0.tar.gz
RUN tar -C /usr/local -xzf libtensorflow-cpu-linux-x86_64-2.3.0.tar.gz
RUN ldconfig /etc/ld.so.conf.d

WORKDIR /apps
RUN mkdir src
COPY ./* ./src/

WORKDIR /apps/src
ENV PATH=$PATH:/usr/local/go/bin

RUN go build main.go

CMD ["./main"]