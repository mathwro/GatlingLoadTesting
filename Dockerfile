FROM java:8-jdk

# working directory for gatling
WORKDIR /opt

# Gating version
ENV GATLING_VERSION 3.0.0

# create directory for gatling install
RUN mkdir -p gatling

# install gatling
RUN mkdir -p /tmp/downloads && \
  curl -sf -o /tmp/downloads/gatling-$GATLING_VERSION.zip \
  -L https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/$GATLING_VERSION/gatling-charts-highcharts-bundle-$GATLING_VERSION-bundle.zip && \
  mkdir -p /tmp/archive && cd /tmp/archive && \
  unzip /tmp/downloads/gatling-$GATLING_VERSION.zip && \
  mv /tmp/archive/gatling-charts-highcharts-bundle-$GATLING_VERSION/* /opt/gatling/

# change context to gatling directory
WORKDIR  /opt/gatling

RUN mv /opt/gatling/user-files /opt/gatling/user-files-backup
COPY ./user-files /opt/gatling/user-files

# set directories below to be mountable from host
VOLUME ["/opt/gatling/conf","/opt/gatling/results","/opt/gatling/user-files"]

# set environment variables
ENV PATH /opt/gatling/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV GATLING_HOME /opt/gatling

ENTRYPOINT ["gatling.sh"]
