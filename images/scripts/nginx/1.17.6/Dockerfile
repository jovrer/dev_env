FROM alpine

MAINTAINER jovrer <jovrer@hotmail.com>

COPY ./src/* ./

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash zlib zlib-dev openssl openssl-dev pcre pcre-dev ca-certificates wget \    
    && update-ca-certificates \
    && echo "down..." \    
    # && wget http://nginx.org/download/nginx-1.17.6.tar.gz \
    && tar -zxf nginx-1.17.6.tar.gz \
    && apk add gcc g++ automake make \
    && cd ./nginx-1.17.6 \
    && ./configure \
    && make && make install \
    && apk del gcc g++ automake make \ 
    && rm -rf /var/cache/apk/* \
    && rm -f nginx-1.17.6.tar.gz \
    && rm -rf nginx-1.17.6
    
RUN apk add openssh
# WORKDIR /usr/local/nginx
# COPY kibana.yml ./config/

# ENTRYPOINT [ "/usr/local/nginx/sbin/nginx", "-g", "daemon off;" ]

CMD [ "/usr/local/nginx/sbin/nginx", "-g", "daemon off;" ]

EXPOSE 80