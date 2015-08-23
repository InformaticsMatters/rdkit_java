FROM ubuntu:15.04
MAINTAINER tdudgeon@informaticsmatters.com
# WARNING this takes about an hour to build
# WARNING building the java wrappers does not work at present

ENV RDKIT_BRANCH=Release_2015_03_1

RUN apt-get update && apt-get install -y \
 flex\
 bison\
 build-essential\
 python-numpy\
 cmake\
 python-dev\
 sqlite3\
 libsqlite3-dev\
 libboost-dev\
 libboost-python-dev\
 libboost-regex-dev\
 openjdk-8-jdk\
 swig2.0\
 git\
 wget


RUN git clone -b $RDKIT_BRANCH --single-branch https://github.com/rdkit/rdkit.git

ENV RDBASE=/rdkit
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RDBASE/lib
ENV PYTHONPATH=$PYTHONPATH:$RDBASE
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

RUN mkdir $RDBASE/External/java_lib
RUN wget -O $RDBASE/External/java_lib/junit.jar http://search.maven.org/remotecontent?filepath=junit/junit/4.12/junit-4.12.jar
RUN wget -O $RDBASE/External/java_lib/hamcrest-core.jar http://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar

RUN mkdir $RDBASE/build
WORKDIR $RDBASE/build
RUN cmake -D RDK_BUILD_SWIG_WRAPPERS=ON .. 
RUN make
RUN make install

WORKDIR /
