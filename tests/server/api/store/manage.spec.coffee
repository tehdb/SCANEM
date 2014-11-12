_ 			= require('lodash')
expect 		= require('chai').expect
sinon 		= require('sinon')

superagent = require('superagent');
agent = superagent.agent();

db = require('monk')('localhost/SCANEM')

URL = 'http://localhost:3030/api/store'

products_db = db.get('products')

product = null
PRODUCT = _.constant({
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
})

describe.only 'api products manager', ->

	before (done) ->
		agent
			.post( "#{URL}/product/insert" )
			.send( PRODUCT() )
			.end ( err, res) ->
				expect(res.status).to.equal(200)
				product = res.body
				done()


	after (done) ->
		products_db.remove {ean: PRODUCT().ean}, (err ) ->
			expect( err ).to.be.null
			done()


	it 'should select one product by id', (done) ->
		agent
			.get( "#{URL}/product/#{product._id}")
			.end (err, res) ->
				expect(res.status).to.equal(200)
				done()

