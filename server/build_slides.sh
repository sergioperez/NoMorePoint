#!/usr/bin/bash
SLIDES_SRC="/opt/slides/src/slides.adoc"
SLIDES_OUTPUT="/opt/slides/src/index.html"
echo $PWD hola > /tmp/test
asciidoctor-revealjs -a revealjsdir=https://cdn.jsdelivr.net/npm/reveal.js@3.9.2 \
  ${SLIDES_SRC} -o ${SLIDES_OUTPUT}

if [ ! -n "${DISABLE_LIVE_RELOAD}" ]
then
  # Inject live_update
  sed -i 's/<\/head>/\<script type="text\/javascript" src=".\/js\/live_update.js"><\/script>\<\/head>/' ${SLIDES_OUTPUT}
  # Set slides output to true
  sed -i 's/history: false/history: true/' ${SLIDES_OUTPUT}

  # Get pids of processes invoked by websocketd
  websocket_pid=$(ps -aux | grep websocket_update | grep -vE "grep|websocketd" | awk '{print $2}')

  # Kill old websocket connections
  kill ${websocket_pid}
fi
