FROM informaticsmatters/rdkit:Release_2016_09_2
MAINTAINER Tim Dudgeon <tdudgeon@informaticsmatters.com>

RUN apt-get update && apt-get install -y openjdk-8-jdk

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# base image already has RDKit built. We just need the java stuff
WORKDIR $RDBASE/build
RUN cmake -DRDK_BUILD_SWIG_WRAPPERS=ON -DRDK_BUILD_INCHI_SUPPORT=ON .. 
RUN make
RUN make install

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RDBASE/Code/JavaWrappers/gmwrapper
ENV CLASSPATH=$RDBASE/Code/JavaWrappers/gmwrapper/org.RDKit.jar

WORKDIR $RDBASE 
