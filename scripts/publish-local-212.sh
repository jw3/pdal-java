#!/usr/bin/env bash

# --suffix: sets the suffix you want to publish lib with

for i in "$@"
do
    case $i in
        --suffix=*)
            PDAL_VERSION_SUFFIX="${i#*=}"
            shift
            ;;
        *)
            ;;
    esac
done

export PDAL_VERSION_SUFFIX=${PDAL_VERSION_SUFFIX-"-SNAPSHOT"}

PDAL_DEPEND_ON_NATIVE=false ./sbt "-212" "project core" publishLocal
PDAL_DEPEND_ON_NATIVE=false ./sbt "-212" "project core-scala" publishLocal
./sbt "-212" "project native" publishLocal
