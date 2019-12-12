# FROM node

# MAINTAINER jovrer <jovrer@hotmail.com>

# ENV STACK 7.4.2

# # RUN apk update \
# #     && apk upgrade \
# #     && apk add --no-cache bash openjdk8 nodejs
    
# RUN echo "down kibana" \
#     && pwd \
#     && wget https://artifacts.elastic.co/downloads/kibana/kibana-${STACK}-linux-x86_64.tar.gz \
#     && tar -zxf kibana-${STACK}-linux-x86_64.tar.gz \
#     && mv kibana-${STACK}-linux-x86_64 /usr/local/kibana     
    
# RUN rm kibana-${STACK}-linux-x86_64.tar.gz \
#     && rm -rf /var/cache/apk/*

# WORKDIR /usr/local/kibana
# COPY kibana.yml ./config/    

# ENTRYPOINT [ "/usr/local/kibana/bin/kibana", "--allow-root"]

# # CMD [ "executable" ]

# EXPOSE 12001

FROM alpine

MAINTAINER jovrer <jovrer@hotmail.com>

ENV STACK 7.1.1
ENV CPU_NUMS 4  

COPY ./src/* ./

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash openjdk8 linux-headers ca-certificates wget python gcc g++ automake make  \
    && update-ca-certificates \
    && echo "down..." \  
    # && wget https://artifacts.elastic.co/downloads/kibana/kibana-${STACK}-linux-x86_64.tar.gz \
    && tar -zxf kibana-${STACK}-linux-x86_64.tar.gz && mv kibana-${STACK}-linux-x86_64 /usr/local/kibana 
    # && wget https://nodejs.org/download/release/v10.15.2/node-v10.15.2.tar.gz \
RUN tar -zxf node-v10.15.2.tar.gz \
    && cd ./node-v10.15.2 \
    && ./configure && make -j${CPU_NUMS} && make install 
RUN cd /usr/local/kibana \
    && mv ./node/bin/node ./node/bin/node_bak && ln -s /usr/local/bin/node ./node/bin/node \
    && cd / \
    && rm kibana-${STACK}-linux-x86_64.tar.gz \
    && rm -rf /var/cache/apk/* \
    && rm -f node-v10.15.2.tar.gz \
    && rm -rf ./node-v10.15.2 \ 
    && apk del gcc g++ automake make

RUN apk add shadow
RUN mkdir /var/mail
RUN groupadd kibana \ 
    && useradd -g kibana kibana \
    && chown -R kibana:kibana /usr/local/kibana

# COPY kibana.yml ./config/

# ENTRYPOINT [ "/usr/local/kibana/bin/kibana", "--allow-root"]

COPY ./entrypoint.sh /usr/bin/
RUN chmod 755 /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh" ]


EXPOSE 12001