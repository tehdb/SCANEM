/*
 */


describe("HTML-Table-Rendering aus JSON-Daten ", function (){
  // Fixtures/Ausführungsumgebung
  beforeEach(function(){
    if ($('#data').length === 0) {
      $('body').append('<table><tbody id="data"></tbody></table>');
    }
  });
  afterEach(function(){
    $('#data').empty();
  });

  it("rendert mit vorhandnen Daten 3 Zeilen", function(){
    // Test-Daten vorbereiten
    var data = [
      {"id":1001, "name":"mustermann", "vorname":"max"},
      {"id":1002, "name":"lauter", "vorname":"lisa"},
      {"id":1003, "name":"lyse", "vorname":"anna"}
    ];

    // Testkandidat ausführen
    APP.rendereTabelleNachJSON(data);
    // Erwartetes Ergebnis
    var zeilenZahl = 3;
    // Tatsächliches Ergebnis
    var gerendert = $('#data').find('tr').size();
    // Erwartetes Ergebnis gleich tatsächlichem?
    expect(zeilenZahl).toBe(gerendert);
  });
});

describe("HTML-Table-Rendering, mit Spy (Spion) getestet ", function (){
  // Fixtures/Ausführungsumgebung
  beforeEach(function(){
    if ($('#data').size() === 0) {
      $('body').append('<table id="data"></table>');
    }

    // Hier erfolgt auch die Initialisierung des Spies
    spyOn(APP, 'rendereTabellenzeile');
  });
  afterEach(function(){
    $('#data').empty();
  });

  it("verwendet APP.rendereTabellenzeile()", function(){
    // Test-Daten vorbereiten
    var data = [
      {"id":1001, "name":"mustermann", "vorname":"max"},
      {"id":1002, "name":"lauter", "vorname":"lisa"},
      {"id":1003, "name":"lyse", "vorname":"anna"}
    ];

    // Testkandidat ausführen
    APP.rendereTabelle(data);

    // Erwartetes Ergebnis: Spies überprüfen
    expect(APP.rendereTabellenzeile).toHaveBeenCalled();

  });
  
describe("HTML-Table-Rendering, mit Spy (Spion) getestet ", function (){
  // Fixtures/Ausführungsumgebung
  beforeEach(function(){
    if ($('#data').size() === 0) {
      $('body').append('<table id="data"></table>');
    }

    // Hier erfolgt auch die Initialisierung des Spies
    spyOn(APP, 'rendereTabellenzeile').and.throwError("Meldung..");
  });
  afterEach(function(){
    $('#data').empty();
  });

  it("verwendet APP.rendereTabellenzeile()", function(){
    // Test-Daten vorbereiten
    var data = [
      {"id":1001, "name":"mustermann", "vorname":"max"},
      {"id":1002, "name":"lauter", "vorname":"lisa"},
      {"id":1003, "name":"lyse", "vorname":"anna"}
    ];

    // Testkandidat ausführen
    APP.rendereTabelle(data);

    // Erwartetes Ergebnis: Spies überprüfen
    expect(APP.rendereTabellenzeile).toHaveBeenCalled();
    //expect(APP.rendereTabelle).// ... fehler richtig behandelt?

  });
});