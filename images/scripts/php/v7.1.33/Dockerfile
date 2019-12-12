FROM alpine

MAINTAINER jovrer <jovrer@hotmail.com>

ENV CPU_NUMS 4

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash libxml2-dev re2c bison openssl openssl-dev bzip2 bzip2-dev curl curl-dev ca-certificates openssh \
    && update-ca-certificates

COPY ./src/* ./

RUN echo "down..." \    
    # && wget https://github.com/php/php-src/archive/php-7.1.33.tar.gz \
    && ls \
    && tar -zxf php-7.1.33.tar.gz \
    # && wget http://www.ijg.org/files/jpegsrc.v9.tar.gz \
    && tar -zxf jpegsrc.v9.tar.gz

    # && wget https://xdebug.org/files/xdebug-2.8.0.tgz && tar -zxf xdebug-2.8.0.tgz &&  mv xdebug-2.8.0 /usr/local/php/ext/ \
    # && wget https://github.com/tideways/php-xhprof-extension/archive/v5.0.2.tar.gz && tar -zxf v5.0.2.tar.gz &&  mv v5.0.2 /usr/local/php/ext/xhprof \    

RUN apk add gcc g++ automake make autoconf


# RUN ls ./php-src-php-7.1.33

RUN cd ./jpeg-9 && ./configure && make -j${CPU_NUMS} && make install

RUN apk add libpng libpng-dev freetype freetype-dev gettext gettext-dev openldap openldap-dev libxslt libxslt-dev
RUN mkdir /usr/lib64 && cp -frp /usr/lib/* /usr/lib64/


RUN cd ./php-src-php-7.1.33 \
    && ./buildconf --force \
    && ./configure --with-curl --with-freetype-dir --with-gd --with-gettext --with-iconv-dir --with-kerberos --with-libdir=lib64 --with-libxml-dir --with-mysqli --with-openssl --with-pcre-regex --with-pdo-mysql --with-pdo-sqlite --with-pear --with-png-dir --with-jpeg-dir --with-xmlrpc --with-xsl --with-zlib --with-bz2 --with-mhash --enable-fpm --enable-bcmath --enable-libxml --enable-inline-optimization --enable-gd-native-ttf --enable-mbregex --enable-mbstring --enable-opcache --enable-pcntl --enable-shmop --enable-soap --enable-sockets --enable-sysvsem --enable-sysvshm --enable-xml --enable-zip --with-ldap  
RUN cd ./php-src-php-7.1.33 && make -j${CPU_NUMS}
RUN cd ./php-src-php-7.1.33 && make install 

# RUN mv /usr/local/etc/php-fpm.conf.default /usr/local/etc/php-fpm.conf
# RUN mkdir /usr/local/NONE/ \
#     && ln -s /usr/local/etc /usr/local/NONE/etc \
#     && mv /usr/local/NONE/etc/php-fpm.d/www.conf.default /usr/local/NONE/etc/php-fpm.d/www.conf

COPY ./conf/php-fpm.conf /usr/local/etc/
COPY ./conf/php-fpm.d/* /usr/local/etc/php-fpm.d/

RUN apk del gcc g++ automake make autoconf \
    && rm -rf /var/cache/apk/* \
    && rm -f ./php-src-php-7.1.33.tar.gz \
    && rm -rf ./php-src-php-7.1.33



# WORKDIR /usr/local/php
# COPY kibana.yml ./config/

# ENTRYPOINT [ "/usr/local/kibana/bin/kibana", "--allow-root"]

CMD [ "/usr/local/sbin/php-fpm", "-F" ]

EXPOSE 9000