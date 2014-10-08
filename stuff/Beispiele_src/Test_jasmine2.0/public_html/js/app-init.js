/*
 * app_init
 * Heraus-refaktoriertes Init-Script, das nur die Anwendung initialisiert.
 * Die zu prüfenden Bibliotheken sind in einer eigenen Datei ausgelagert.
 *
 */

$(document).ready(function() {
  // load data
  $.ajax({
    url: 'data.json',
    success: APP.rendereTabelle
  });
});


