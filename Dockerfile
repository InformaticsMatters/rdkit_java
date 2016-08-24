# currently need backports as openjdk-8-jdk not available on vanilla jessie
FROM debian:jessie-backports
MAINTAINER Tim Dudgeon <tdudgeon@informaticsmatters.com>
# WARNING this takes about an hour to build

RUN apt-get update && apt-get install -y \
 build-essential\
 python-numpy\
 cmake\
 python-dev\
 sqlite3\
 libsqlite3-dev\
 libboost-dev\
 libboost-system-dev\
 libboost-thread-dev\
 libboost-serialization-dev\
 libboost-python-dev\
 libboost-regex-dev\
 swig2.0\
 git\
 openjdk-8-jdk\
 curl 

ENV RDKIT_BRANCH=master
RUN git clone -b $RDKIT_BRANCH --single-branch https://github.com/rdkit/rdkit.git

ENV RDBASE=/rdkit
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

RUN mkdir $RDBASE/build
WORKDIR $RDBASE/build
RUN cmake -D RDK_BUILD_SWIG_WRAPPERS=ON -DRDK_BUILD_INCHI_SUPPORT=ON .. 
RUN make
RUN make install

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RDBASE/lib:/usr/lib/x86_64-linux-gnu:/rdkit/lib:$RDBASE/Code/JavaWrappers/gmwrapper
ENV PYTHONPATH=$PYTHONPATH:$RDBASE
ENV CLASSPATH=$RDBASE/Code/JavaWrappers/gmwrapper/org.RDKit.jar

WORKDIR $RDBASE 
