/*
 * AJAX-APP - hier als Namespace-Objekt direkt deklariert.
 * Möglich wäre ebenso der Aufbau mit Konstruktor-Funktion und prototype
 */
var APP = {
  editingNode: null
};

/**
 * Success-Handler, heraus-refaktoriert
 */
APP.rendereTabelleNachJSON = function (data) {
  var l = (data && data.length) ? data.length : 0;
  var i = 0;

  for (i = 0; i < l; i++) {
    var tr = $('#data').append('<tr>');
    var id = data[i].id;
    var nodeID = 'vorname-' + id;
    var td1 = $('<td>').text(data[i].id);
    $(tr).append(td1);
    console.log(td1);
    $(tr).append($('<td>').text(data[i].name));
    $(tr).append($('<td>').text(data[i].vorname).prop('id', nodeID).click(APP.createHandler(nodeID, id)));
  }
};

/**
 * Alternativ, weiter refaktoriert
 * @param {type} data
 * @returns {undefined}
 */
APP.rendereTabelle = function (data) {
  var l = (data && data.length) ? data.length : 0;
  var i = 0;

  for (i = 0; i < l; i++) {
    $('#data').append(APP.rendereTabellenzeile(data[i]));
  }
};

APP.rendereTabellenzeile = function (item) {
  var tr = $('<tr>');
  var id = item.id;
  var nodeID = 'vorname-' + id;
  var td1 = $('<td>').text(item.id);
  $(tr).append(td1);
  console.log(td1);
  $(tr).append($('<td>').text(item.name));
  $(tr).append($('<td>').text(item.vorname).prop('id', nodeID).click(APP.createHandler(nodeID, id)));
  return tr;
}

APP.createHandler = function (nodeID, id) {
  return function () {
    APP.edit(nodeID, id);
  };
}
;

APP.edit = function (nodeID, id) {
  // Zelle bereits in Bearbeitung?
  if (nodeID === editingNode) {
    return;
  }
  editingNode = nodeID;

//        console.log(i);
  console.log(nodeID);
  console.log(id)

  var td = $('#' + nodeID);

  var field = $('<input>').val($(td).text()).blur(function () {
    // Hier: nur bei blur() Bearbeitung beenden und speichern
    // Wert aus field einfügen und damit field aus DOM entfernen
    $(td).text($(field).val());
    APP.save(nodeID, ($(field).val()));
  });
  $(td).html(field);
}

APP.save = function (nodeID, value) {
  console.log(nodeID);
  console.log(value);
  var info = nodeID.split('-');
  var field = info[0];
  var id = info[1];

  $.ajax({
    url: 'save_data.php',
    data: {field: field, id: id, value: value},
    type: 'POST',
    success: function () {
      // TBD
    },
    error: function () {
      // TBD
    }
  });
//        $('#'+nodeID).text();
}


