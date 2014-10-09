
// Server code
var handler = require('./simple_httpserver2.lib.js');
console.log(handler);


var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end(handler.handle(req));
}).listen(1337, '127.0.0.1');
console.log('Server running at http://127.0.0.1:1337/');
