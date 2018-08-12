FROM python:2

ADD VERSION .
RUN mkdir /data
COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN apt-get update && \
    apt-get install -y default-jre graphviz

ENV PLANTUML_DIR /usr/local/plantuml
ENV PLANTUML_JAR plantuml.jar
ENV PLANTUML $PLANTUML_DIR/$PLANTUML_JAR
RUN mkdir -p $PLANTUML_DIR && \
    wget "http://sourceforge.net/projects/plantuml/files/plantuml.1.2017.20.jar/download" \
    --no-check-certificate -O $PLANTUML
COPY plantuml /usr/local/bin/plantuml
RUN chmod 755 /usr/local/bin/plantuml
# RUN echo "Yes, do as I say!" | \
#    apt-get remove --purge -y --force-yes $ (apt-mark showauto) \
#    && rm -rf /var/lib/apt/lists/*

EXPOSE 5000
VOLUME /data
