FROM alpine

MAINTAINER jovrer <jovrer@hotmail.com>

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash openssh ca-certificates wget \
    && update-ca-certificates 
    
COPY ./src/* ./

RUN echo "down..." \    
    # && wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.18.tar.gz \
    && tar -zxf mysql-8.0.18.tar.gz     

RUN apk add gcc g++ automake make 

RUN cd mysql-8.0.18 \
    && ./configure \
    && make && make install    

RUN apk del gcc g++ automake make \ 
    && rm -rf /var/cache/apk/*

# WORKDIR /usr/local/mariadb
# COPY kibana.yml ./config/

# ENTRYPOINT [ "/usr/local/kibana/bin/kibana", "--allow-root"]

# CMD [ "executable" ]

EXPOSE 9321