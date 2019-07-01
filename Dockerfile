FROM debian

RUN groupadd -g 3333 mgmt && \
    useradd -r -u 3333 -m -g mgmt mgmt && \
    apt-get update && \
    #apt-get install -y nano apt-utils && \
    apt-get install -y wget bash curl dnsutils 

USER mgmt

RUN cd ~ && \
	curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.2.0-linux-x86_64.tar.gz && \
	tar -xvf elasticsearch-7.2.0-linux-x86_64.tar.gz  && \
	rm elasticsearch-7.2.0-linux-x86_64.tar.gz

EXPOSE 9300
EXPOSE 9200
    
VOLUME /config
VOLUME /data
VOLUME /logs

ENV ES_PATH_CONF="/config"
WORKDIR /home/mgmt/elasticsearch-7.2.0

CMD bin/elasticsearch