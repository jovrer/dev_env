FROM alpine

MAINTAINER jovrer <jovrer@hotmail.com>

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash 

RUN apk add openssh

COPY ./src/* ./
RUN echo "down..." \    
    # && wget https://downloads.mariadb.org/f/mariadb-10.4.10/source/mariadb-10.4.10.tar.gz \
    && tar -zxf mariadb-10.4.10.tar.gz     

RUN apk add gcc g++ automake make 

RUN apk add cmake 

RUN apk search e2fsprogs
RUN apk add ncurses ncurses-dev gnutls gnutls-dev e2fsprogs e2fsprogs-dev linux-headers

RUN cd mariadb-10.4.10 \    
    && cmake .

RUN cd mariadb-10.4.10 \    
    && ls \
    # && ./configure \
    && make && make install    

RUN apk del gcc g++ automake make \ 
    && rm -rf /var/cache/apk/*

# WORKDIR /usr/local/mariadb
# COPY kibana.yml ./config/

# ENTRYPOINT [ "/usr/local/kibana/bin/kibana", "--allow-root"]

# CMD [ "executable" ]

EXPOSE 9321