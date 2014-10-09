/*
 *  This code is released under Creative Commons Attribution 4.0 International
 *  (CC BY 4.0) license, http://creativecommons.org/licenses/by/4.0/legalcode .
 *  That means:
 *
 *  You are free to:
 *
 *      Share — copy and redistribute the material in any medium or format
 *      Adapt — remix, transform, and build upon the material
 *               for any purpose, even commercially.
 *
 *      The licensor cannot revoke these freedoms as long as you follow the
 *      license terms.
 *
 *  Under the following terms:
 *
 *      Attribution — You must give appropriate credit, provide a link to the
 *      license, and indicate if changes were made. You may do so in any
 *      reasonable manner, but not in any way that suggests the licensor endorses
 *      you or your use.
 *
 *  No additional restrictions — You may not apply legal terms or technological
 *  measures that legally restrict others from doing anything the license
 *  permits.
 *
 *
 *  2014 Aeonium Software Systems, Robert Rohm.
 */


requirejs.config({
    // Standard-URL, von der alle Skripte geladen werden sollen.
    // Mit dieser URL werden alle "Modul-IDs" aufgelöst".
    baseUrl: 'js/lib',

    // Ausnahme-Regelungen sind möglich, z.B. hier für das "app"-Verzeichnis.
    // Hier werden generell Pfad-Angaben gemacht, keine Verweise auf einzelne
    // Skripte
    paths: {
        app: '../app'
    }
});

// Initialisierung der eigentlichen Anwendunslogik:
requirejs(['jquery', 'app/sub'],
function   ($,        sub) {
    // Im Scope dieser Funktion sind die angegeben Module geladen und verfügbar,
    // hier kann mit den Modulen jquery und sub gearbeitet werden.
    console.log($);
    $('#container').html("JS-Anwendung mit require.js und jQuery erfolgreich initialisiert.");

    // Zugriff auf Funktionen aus dem sub-Skript:
    mySubFunction();

    // aber: Ein "Modul" im  sinne von require.js wird hier noch nicht verwendet.
    // Kein abgetrennter eigener Scope!
    console.log(sub)
});