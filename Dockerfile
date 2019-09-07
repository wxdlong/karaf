FROM wxdlong/jdk:8u201 as jdk

FROM centos:7

##service:jmx:http-remoting-jmx://localhost:32771
#install packages
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y vim iproute ping tar wget

COPY --from=jdk /* /tmp/


ENV JAVA_HOME /opt/jdk1.8.0_201


## Default userName=wxdlong, password=12345678

RUN wget http://mirror.bit.edu.cn/apache/karaf/4.2.6/apache-karaf-4.2.6.tar.gz -O - | tar -zxf - -C /opt && \
    tar -xvf /tmp/jdk-8u201-linux-x64.tar.gz -C /opt && \
    echo "export JAVA_HOME=${JAVA_HOME}" >> /etc/profile && \
    echo 'export PATH=${WILDFLY_HOME}/bin:${JAVA_HOME}/bin:${PATH}' >> /etc/profile && \
    rm -rf /tmp/*.tar.gz

    
EXPOSE 5005  8080
WORKDIR /opt/
CMD ["tail","-f","/dev/null"]
