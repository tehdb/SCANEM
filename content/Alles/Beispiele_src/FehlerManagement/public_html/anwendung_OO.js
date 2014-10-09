/* 
 * Anwendungsscript - rendert Content ins HTML
 * 2. Fassung - Fehlermanagement, objekt-orientiert; 
 * 
 * Wichtige Aspekte sind hier: 
 * - Schützen von kritischen Blöcken mit try
 * - Fangen von Fehlern mit catch-Blöcken
 * - zentralisierte Behandlung von Fehlern in einer eigenen App.-Obekt-Methode
 * - Besondere Situation bei asynchroner Ausführung (AJAX!)
 *   Exceptions können nicht direkt gefangen werden
 * - window.onerror-Handler behandelt Fehler, "schluckt" sie aber nicht. 
 *   Exakter: der Handler wird erst aufgerufen, nachdem der Browser den Fehler
 *   registriert hat.
 */

$(document).ready(function () {
    myApp.rendereContent();
});

var APP = function(){
    // 
};

APP.prototype.rendereContent = function () {
    // Standard-Vorgehen: Ausführung im geschützten Block: 
    try {
        this.doSomething();
    } catch (exception){
        // Hier: ggf. Exception behandeln:
        this.behandleFehler(exception);        
    }

    // ACHTUNG! Asynchroner Aufruf!!!
    var me = this;
    $('#content').load('fragment_.html', function (data, status) {
        
        if (status === 'error') {
            // Fehler als "Exception" signalisieren
            // throw 'Fehler, Daten nicht geladen.'; // geht nicht, kann nicht gefangen werden!
            // ... es vsei denn über window.onerror
            me.behandleFehler('Fehler, Daten nicht geladen.');
        }
        console.log(data, status);
    });
};
APP.prototype.doSomething = function (){
  // Function verursacht Fehler
    throw "Fehler, kann something nicht erledigen.";
};

/**
 * Zentrale Methode des APP-Objekts, um Fehler zu behandeln 
 * und an den User zu melden. 
 * 
 * @param {type} exception
 * @returns {undefined}
 */
APP.prototype.behandleFehler = function (exception){
    console.log('Zentrale Fehlerbehandlung: ', exception);
    $('#error-message').html('<strong>' + exception + '</strong>');
};


var myApp = new APP();

// Problematisch, da Fehler nicht "komplett" abgefangen werden: 
//window.onerror = function(e){
//    console.log('window.onerror ', e);
//}