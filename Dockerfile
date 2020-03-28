FROM centos:8
ARG SLIDES_PORT=8123
ARG STATUS_PORT=8124

ENV SLIDES_PORT=${SLIDES_PORT}
ENV DISABLE_LIVE_RELOAD=${DISABLE_LIVE_RELOAD}
ENV STATUS_PORT=${STATUS_PORT}

RUN curl https://sergio.link/files/watchman.tar.gz -o /tmp/watchman.tar.gz \
	&& tar zxvf /tmp/watchman.tar.gz -C /usr/bin/ \
	&& rm /tmp/watchman.tar.gz \
	&& chmod +x /usr/bin/watchman \
	&& mkdir -p /usr/local/var/run/watchman/ \
	&& yum install -y ruby \
	&& gem install asciidoctor-revealjs \
	&& mkdir -p /opt/slides/src \
	&& yum install -y https://github.com/joewalnes/websocketd/releases/download/v0.3.0/websocketd.0.3.0.x86_64.rpm \
	&& yum clean all \
	&& rm -rf /var/cache/yum

COPY server/ /opt/slides/
EXPOSE ${SLIDES_PORT}/tcp
EXPOSE ${STATUS_PORT}/tcp

CMD /opt/slides/slides_server.sh
