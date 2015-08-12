FROM tutum/jboss:as5

MAINTAINER info.inspectit@novatec-gmbh.de

# create directory for database
RUN mkdir -p /database/database 

# Add dvdstore files into the Container
ADD dvdstore-for-docker.zip ./

# unzip dvdstore files and place them at correct locations
RUN unzip dvdstore-for-docker.zip \
&& mv h2.jar /database/ \
&& ln -s /database/h2.jar /jboss-5.1.0.GA/server/default/lib/. \
&& mv dvdstore22.h2.db /database/database/ \
# add ear-file to hot deployment directory of JBoss 
&& mv dvdstore.ear /jboss-5.1.0.GA/server/default/deploy/ \
&& mv dvdstore-prod-ds.xml /jboss-5.1.0.GA/server/default/deploy/dvdstore-ds.xml \
# clean up zip-file
&& rm -f dvdstore-for-docker.zip
