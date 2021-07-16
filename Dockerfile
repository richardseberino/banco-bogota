FROM hondabhyat/ace-mqclient

ENV LICENSE=accept

RUN mkdir -p /home/aceuser/initial-config/bars 
COPY BARfiles/*.bar /home/aceuser/initial-config/bars




