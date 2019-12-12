FROM centos:6

MAINTAINER jovrer <jovrer@hotmail.com>

ENV STACK 7.4.2

COPY ./src/* ./

RUN echo "down ..." \
    && pwd \    
    && tar -zxf elasticsearch-${STACK}-linux-x86_64.tar.gz \
    && mv ./elasticsearch-${STACK} /usr/local/elasticsearch


COPY ./elasticsearch.yml /usr/local/elasticsearch/config/

RUN groupadd elas \ 
    && useradd -g elas elas \
    && chown -R elas:elas /usr/local/elasticsearch


RUN rm elasticsearch-${STACK}-linux-x86_64.tar.gz 


COPY ./entrypoint.sh /usr/bin/
RUN chmod 755 /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh" ]

EXPOSE 12002