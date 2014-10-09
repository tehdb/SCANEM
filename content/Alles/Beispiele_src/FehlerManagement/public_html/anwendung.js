/* 
 * Anwendungsscript - rendert Content ins HTML
 * 1. Fassung
 */

$(document).ready(function(){
    // Für Fehlermanagement schlecht - kein Feedback! 
    //$('#content').load('fragment.html');
    
    // 1) Besser: Mit Callback für Möglichkeit sorgen, 
    // aus dem Framework Feedback zu erhalten
    $('#content').load('fragment_.html', function(data, status){
        
        // 2) Status-Code abfragen (diagnostizieren) und verarbeiten:
        //    error ist bei Erfolg "success", sonst "error"
        if (status === 'error') {
            
            // 3) Feedback an user
            $('#content').html('Fehler, Daten nicht geladen.');
        }
        console.log(data, status);
    });
});


