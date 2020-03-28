#!/usr/bin/bash
watchman watch "/opt/slides/src/" --log-level=2
watchman trigger --log-level=2 -j <<EOT
["trigger", "/opt/slides/src", {
   "name": "rebuild-slides",
   "expression": ["pcre", ".adoc$"],
   "command": ["/opt/slides/build_slides.sh"]
}]
EOT

websocketd --port=${STATUS_PORT} /opt/slides/websocket_update.rb &
ruby -run -ehttpd /opt/slides/src -p ${SLIDES_PORT}
