var ws = new WebSocket("ws://localhost:8124/");
// Once the connection is closed, the website will be reloaded
ws.onclose = function() {
  console.log("reloading")
  location.reload()
}
