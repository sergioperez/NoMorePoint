FROM fedora:35
ARG SLIDES_PORT=8123
ARG STATUS_PORT=8124

ENV SLIDES_PORT=${SLIDES_PORT}
ENV DISABLE_LIVE_RELOAD=${DISABLE_LIVE_RELOAD}
ENV STATUS_PORT=${STATUS_PORT}

RUN dnf install -y watchman ruby rubygem-webrick https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd.0.4.1.x86_64.rpm \
	&& gem install asciidoctor-revealjs \
	&& mkdir -p /opt/slides/src \
	&& dnf clean all && rm -rf /var/cache/yum

COPY server/ /opt/slides/
EXPOSE ${SLIDES_PORT}/tcp
EXPOSE ${STATUS_PORT}/tcp

CMD /opt/slides/slides_server.sh
