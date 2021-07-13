FROM hondabhyat/ace-mqclient

RUN mkdir -p /home/aceuser/initial-config/bars
COPY BARfiles/*.bar /home/aceuser/initial-config/bars




