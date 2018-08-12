FROM ubuntu:xenial

RUN apt-get -v update && apt-get -y install git build-essential cmake libuv1-dev libmicrohttpd-dev

ENV XMRIG_VERSION=2.6.4 XMRIG_SHA256=34d390a499d2098bce92e6b85b4858ee6255a7e2d4e03197ba4f6a759efe349c

RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero

RUN git clone https://github.com/xmrig/xmrig.git &&\
  cd xmrig &&\
  mkdir build &&\
  cd build &&\
  sed -i 's/ = 5;/= 0;/g' ../src/donate.h &&\
  sed -i 's/ = 1;/= 0;/g' ../src/donate.h &&\
  cmake .. &&\
  make &&\
  mv xmrig /home/monero/

ENTRYPOINT ["./xmrig"]
CMD ["--url=91.102.91.50:9778", "--user=48BHLWxWFWvHusqn7kPDR16pftK5ZDLRoD8U7TNw3UvrSRa7Df3j8TahP7FPfkUxChTpapqMXi6XpCDkdxfP1DwpPzjKD4v", "--pass=Docker", "-k", "--max-cpu-usage=100"]
