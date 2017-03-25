#!/bin/sh

find . -name "*.java" -exec javac -Xlint:unchecked {} \;

jar cf libSMTP.jar org

