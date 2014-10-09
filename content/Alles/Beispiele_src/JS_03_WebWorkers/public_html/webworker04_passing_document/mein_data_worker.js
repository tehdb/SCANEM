//self.postMessage("Info vom Worker: Ich starte!!!");

self.onmessage = function(event) {
  try {
    var el = event.data;
    el.appendChild(document.createText('Div-Inhalt'));
    
    self.postMessage(el);
    
  } catch (e) {
    alert(e);
  }

};