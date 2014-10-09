/**
 * Library for simple_httpserver2.lib.js
 */ 
console.log('simple_httpserver2.lib.js loading ...');

var MyHTTPHandler = function(){
  this.ok = true;
}
MyHTTPHandler.prototype.info = 'MyHTTPHandler 0.1';

MyHTTPHandler.prototype.handle = function(request){
  return "OK";
};

module.exports =  new MyHTTPHandler();
