_ 			= require('lodash')
expect 		= require('chai').expect
sinon 		= require('sinon')

superagent = require('superagent');
agent = superagent.agent();

db = require('monk')('localhost/SCANEM')

URL = 'http://localhost:3030/api/store/products'

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
			.post( "#{URL}" )
			.send( PRODUCT() )
			.end ( err, res) ->
				expect(res.status).to.equal(200)
				product = res.body
				done()


	after (done) ->
		products_db.remove {ean: PRODUCT().ean}, (err ) ->
			expect( err ).to.be.null
			done()

	it 'should update a product', (done) ->
		p = _.clone( product )
		p.title = 'Updated test product'

		agent
			.put( URL )
			.send( p )
			.end (err, res) ->
				expect(res.status).to.equal 200
				expect(res.body.title).to.equal p.title
				done()

	it 'should select one product by id', (done) ->
		agent
			.get( "#{URL}/#{product._id}")
			.end (err, res) ->
				expect(res.status).to.equal(200)
				expect(res.body._id).to.equal product._id
				done()

	# xit 'should select products by category', (done) ->
	# 	agent
	# 		.get( "#{URL}&cat=#{product._id}")		# TODO: better way to pass get params

	it 'should select products by color', (done) ->
		c = product.vars[0].colors[0].key
		console.log c
		agent
			.get( "#{URL}/?color=#{c}") 		# TODO: better way to pass get params
			.end (err,res)->
				expect(res.status).to.equal(200)
				console.log res.body
				done()





