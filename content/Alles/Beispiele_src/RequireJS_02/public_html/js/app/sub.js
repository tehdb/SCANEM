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

/**
 * Hier wied der eigene Code in ein RequireJS-Modul verpackt, d.h. alle von
 * dieser Bibliothek bereitzustellenden Variablen und Funktionen werden zu
 * Eigenschaften und Methoden eines zurückgegebenen "Modul"-Objekts.
 *
 * Eventuell benötigte weitere Module, wie z.B. in diesem Fall jQuery, werden
 * ggf. als Abhängigkeiten in einem optionalen vorangestellten Array definiert.
 */
define(['jquery'], function () {

  // Hier wird das Objektliteral sofort zurückgegeben, in der Praxis
  // ist es oft angenehmer, das Objekt vorab schrittweise aufzubauen. 
  return {
    color: "black",
    size: "unisize",
    mySubFunction: function () {
      console.log('mySubFunction');
      $('#container').append("<p>Dieser zweite Absatz stammt aus dem sub-Modul</p>");
    }
  };
});