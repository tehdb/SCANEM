var assert = require("assert")
var handler = require('../simple_httpserver2.lib.js');

describe('Array', function(){
  describe('#indexOf()', function(){
    it('should return -1 when the value is not present', function(){
      assert.equal(-1, [1,2,3].indexOf(5));
      assert.equal(-1, [1,2,3].indexOf(0));
    })
  })
});

describe('HTTP-Handler', function(){
  it('schould handle request and return OK', function(){
    var request = {};
    var expected = 'OK';
    var actual   = handler.handle(request); 
    assert.equal(actual, expected);
  });
});


