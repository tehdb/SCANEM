_ 			= require('lodash')
expect 		= require('chai').expect
sinon 		= require('sinon')

superagent = require('superagent');
agent = superagent.agent();

URL = 'http://localhost:3030/api/store'

_ProductData =
	title: 'Test product'
	ean: 	'123'
	vars: [{
		width: 80
		height: 60
		price: 19.99
		imgs: ['path.jpg']
		colors: [{
			key: 'blue'
			val:
				r: 0
				g: 0
				b: 255
		}]
		orie: 'landscape'
	}]

describe.only 'api products manager', ->

	it 'should create a product', (done) ->
		agent
			.post("#{URL}/insert")
			.send( _ProductData )
			.end ( err, res) ->
				console.log res.body

				expect(res.status).to.equal(200)
				done()
