/*
 * WebSockets-Beispiel 01.
 *
 * Dieses Beispiel illustriert die Verwendung von WebSockets zur
 * Client-Server-Kommunikation - aus Client-Sicht.
 *
 *  © 2014 Aeonium Software Systems, Robert Rohm.
 */
var websocket;

/**
 * Achtung! Der Aufbau einer WebSocket-Verbindung ist ein asynchrone Vorgang!
 * Der Versand der Nachricht darauf daher nicht sofort  angestoßen werden.
 * Die Send-Methode darf erst aufgerufen werden, nachdem die Verbindung aufgebaut
 * worden ist. Dies erfolgt in den entsprechenden Eventhandler onOpen().
 */
function call_websocket() {
  var wsURI = "ws://localhost:8080/web-sockes01_basics/endpoint";
  websocket = new WebSocket(wsURI);

  // Handler für die vier Events:
  websocket.onopen = onOpen;
  websocket.onmessage = onMessage;
  websocket.onerror = onError;
  websocket.onclose = onClose;
}

/**
 * Wenn Verbindung nicht mehr benötigt: schließen
 */
function close_websocket() {
  websocket.close();
}



/**
 * Eventhandler-Funktion für den erfolgreichen Aufbau der Websocket-Verbindung.
 * Hier wird der eigentliche Versand der Nachricht angestoßen.
 *
 * @param {type} evt
 * @returns {undefined}
 */
function onOpen(evt) {
  console.log("onOpen");
  console.log(evt);

  websocket.send("Gruß an den Server ... ");

  console.log("Nachricht an den Server gesendet.");
}


/**
 *  Mit diesem Eventhandler lauscht der Client auf Nachrichten (Antworten!) vom Server.
 *
 * @param {type} evt
 * @returns {undefined}
 */
function onMessage(evt) {
  console.log("onMessage");
  console.log(evt);
  
}

/**
 * Fehler-Behandlung:
 */
function onError(evt) {
  console.log("onError");
  console.log(evt);
}

function onClose(evt) {
  console.log("onClose");
  console.log(evt);
}
