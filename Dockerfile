FROM ubuntu:24.04

ENV JAVA_HOME=/u01/middleware/jdk-11.0.2
ENV PATH=$PATH:${JAVA_HOME}/bin
ENV TOMCAT_HOME=/u01/middleware/aapache-tomcat-9.0.89
ENV PATH=$PATH:${TOMCAT_HOME}/bin


RUN mkdir -p /u01/middleware
WORKDIR /u01/middleware
ADD https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz .
RUN tar -xvzf openjdk-11.0.2_linux-x64_bin.tar.gz
RUN rm openjdk-11.0.2_linux-x64_bin.tar.gz

ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.89/bin/apache-tomcat-9.0.89.tar.gz .
RUN tar -xvzf apache-tomcat-9.0.89.tar.gz
RUN rm apache-tomcat-9.0.89.tar.gz

COPY target/speed.war ${TOMCAT_HOME}/webapps
COPY run.sh /tmp
RUN chmod u+x /tmp/run.sh

ENTRYPOINT [ "/tmp/run.sh" ]