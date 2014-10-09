
package org.meins.websocket.server;

import javax.websocket.OnMessage;
import javax.websocket.server.ServerEndpoint;

/**
 * Diese Klasse implementiert den Server-Endpunkt des WebSockets-Dienstes.
 *
 * @author robert rohm
 */
@ServerEndpoint("/endpoint")
public class MeinWSEndpoint {

  @OnMessage
  public String onMessage(String message) {
    System.out.println("Client sendete: " + message);
    return "Hier folgt die Nachricht";
  }
}
