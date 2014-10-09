
self.postMessage("Info vom Worker: Ich starte!!!");

self.onmessage = function(event) {
  self.postMessage('Worker: ich habe Nachricht bekommen: '+event.data);
};