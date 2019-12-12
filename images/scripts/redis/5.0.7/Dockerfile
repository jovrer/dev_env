FROM alpine

MAINTAINER jovrer <jovrer@hotmail.com>

COPY ./src/* ./

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash linux-headers tcl ca-certificates wget \    
    && update-ca-certificates \
    && echo "down..." \    
    # && wget http://download.redis.io/releases/redis-5.0.7.tar.gz \
    && tar -zxf redis-5.0.7.tar.gz \
    && apk add gcc g++ automake make \
    && cd ./redis-5.0.7 && make && make install \
    && apk del gcc g++ automake make \ 
    && rm -rf /var/cache/apk/* \
    && rm -f ./redis-5.0.7.tar.gz \
    && rm -rf ./redis-5.0.7 \
    && mkdir /etc/redis 

RUN apk add openssh

COPY redis.conf /etc/redis/redis.conf

ENTRYPOINT [ "/usr/local/bin/redis-server"]

# CMD [ "executable" ]

EXPOSE 6379