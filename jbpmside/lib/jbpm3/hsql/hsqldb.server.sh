#!/bin/sh
echo connect to this database with jdbc connection url jdbc:hsqldb:hsql://localhost:1701
java -cp hsqldb.jar org.hsqldb.Server -port 1701 -database ../../build/db/jbpm
