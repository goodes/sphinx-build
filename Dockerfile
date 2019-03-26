FROM python:3.6

ADD VERSION .
RUN mkdir /data
COPY requirements.txt /requirements.txt
RUN pip install --upgrade pip && \
    pip install -r /requirements.txt

RUN echo "deb http://deb.debian.org/debian stretch-backports main" | tee -a /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y default-jre graphviz && \
    apt-get -t stretch-backports install "git" -y

ENV PLANTUML_DIR /usr/local/plantuml
ENV PLANTUML_JAR plantuml.jar
ENV PLANTUML $PLANTUML_DIR/$PLANTUML_JAR
RUN mkdir -p $PLANTUML_DIR && \
    wget "https://sourceforge.net/projects/plantuml/files/1.2019.3/plantuml.1.2019.3.jar/download" \
    --no-check-certificate -O $PLANTUML
COPY plantuml /usr/local/bin/plantuml
RUN chmod 755 /usr/local/bin/plantuml

# RUN echo "Yes, do as I say!" | \
#     apt-get remove --purge -y --force-yes $(apt-mark showauto | grep -v pam) \
#     && rm -rf /var/lib/apt/lists/*


# RUN apt-get update && apt-get -t stretch-backports install "git" -y
RUN git version
EXPOSE 5000
VOLUME /data
