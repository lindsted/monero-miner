FROM ubuntu:xenial

RUN apt-get -y update && apt-get -y install git build-essential cmake libuv1-dev libmicrohttpd-dev openssl

RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero


RUN git clone https://github.com/xmrig/xmrig.git xmrig-src &&\
  cd xmrig-src &&\
  mkdir build &&\
  cd build &&\
  sed -i 's/ = 5;/= 0;/g' ../src/donate.h &&\
  sed -i 's/ = 1;/= 0;/g' ../src/donate.h &&\
  cmake .. &&\
  make &&\
  mv xmrig /home/monero/

ENTRYPOINT ["./xmrig"]
CMD ["--url=pool.supportxmr.com:5555", "--user=48BHLWxWFWvHusqn7kPDR16pftK5ZDLRoD8U7TNw3UvrSRa7Df3j8TahP7FPfkUxChTpapqMXi6XpCDkdxfP1DwpPzjKD4v", "--pass=Docker", "-k", "--max-cpu-usage=100"]
