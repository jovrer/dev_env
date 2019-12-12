FROM alpine

MAINTAINER jovrer <jovrer@hotmail.com>

ENV STACK 7.4.2

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash openjdk8 ca-certificates wget \
    && update-ca-certificates 

COPY ./src/* ./

RUN echo "down..." \
    && pwd \
    # && wget https://artifacts.elastic.co/downloads/logstash/logstash-${STACK}.tar.gz \
    && tar -zxf logstash-${STACK}.tar.gz \
    && mv logstash-${STACK} /usr/local/logstash 

RUN rm logstash-${STACK}.tar.gz \
    && rm -rf /var/cache/apk/*

# ENTRYPOINT [ "/usr/local/logstash/bin/logstash", "&"]

RUN apk add shadow
RUN mkdir /var/mail
RUN groupadd logstash \ 
    && useradd -g logstash logstash \
    && chown -R logstash:logstash /usr/local/logstash

COPY ./entrypoint.sh /usr/bin/
RUN chmod 755 /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh" ]    

EXPOSE 12000