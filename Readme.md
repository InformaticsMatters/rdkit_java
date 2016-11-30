# Dockerfile for building RDkit with Java wrappers.
Includes a very simple Java example in the src directory. 

## Branches

* `master` - build from current RDKit master branch
* `Release_2015_03_1` - build from the Release_2015_03_1 release tag
* `Release_2015_09_2` - build from the Release_2015_09_2 release tag
* `Release_2016_03_1` - build from the Release_2016_03_1 release tag
* `Release_2016_09_2` - build from the Release_2016_09_2 release tag

Run docker like this:
`docker build .`
`docker run -it --rm -v $PWD/src:/examples <container id> bash`

Or alternatively use the pre-built image on Dockerhub: https://hub.docker.com/r/informaticsmatters/rdkit_java/
`docker pull informaticsmatters/rdkit_java
`docker run -it --rm informaticsmatters/rdkit_java bash`

Then in the container:

`cd /examples`
`./run.sh`

Javadocs are built into the directory /rdkit/Code/JavaWrappers/gmwrapper/doc

Note: this build only works with OpenJDK Java. Using Oracle Java fails with errors generating the javadocs.
