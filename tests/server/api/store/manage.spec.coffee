_ 			= require('lodash')
expect 		= require('chai').expect
sinon 		= require('sinon')

superagent = require('superagent');
agent = superagent.agent();

db = require('monk')('localhost/SCANEM')

URL = 'http://localhost:3030/api/store/products'

products_db = db.get('products')

_data = require('../data/products')
_products = null

# PRODUCT = data.singleProduct
# PRODUCTS = data.multipleProducts
# console.log testProducts

describe.only 'api products manager', ->

	# create one product
	# before (done) ->
	# 	agent
	# 		.post( "#{URL}" )
	# 		.send( PRODUCTS[0] )
	# 		.end ( err, res) ->
	# 			expect(res.status).to.equal(200)
	# 			product = res.body
	# 			done()

	# insert multiple prdocuts
	before (done) ->
		agent
			.post( URL )
			.send( _data.multipleProducts )
			.end ( err, res) ->
				expect(res.status).to.equal(200)
				_products = res.body
				expect(_products).to.have.length( _data.multipleProducts.length )
				done()

	# clean up - remove products from db
	after (done) ->
		eans = []
		eans.push(p.ean) for p, idx in _products
		products_db.remove {ean: {$in: eans}}, (err ) ->
			expect( err ).to.be.null
			done()


	it 'should insert a single product', (done) ->
		agent
			.post( URL )
			.send( _data.singleProduct )
			.end (err, res) ->
				expect(res.status).to.equal(200)
				expect(res.body).to.have.length( 1 )
				_products.push( res.body[0] )
				done()


	it 'should update a product', (done) ->
		p = _products[0] #_.clone( products[] )
		p.title += "***UPDATED***"

		agent
			.put( URL )
			.send( p )
			.end (err, res) ->
				expect(res.status).to.equal 200
				expect(res.body.title).to.equal p.title
				_products[0] = res.body
				done()


	it 'should select one product by id', (done) ->
		p = _products[0]
		agent
			.get( "#{URL}/#{p._id}")
			.end (err, res) ->
				expect(res.status).to.equal(200)
				expect(res.body._id).to.equal p._id
				done()

	# xit 'should select products by category', (done) ->
	# 	agent
	# 		.get( "#{URL}&cat=#{product._id}")		# TODO: better way to pass get params

	xit 'should select products by size', (done) ->
		size = "#{product.vars[0].width}x#{product.vars[0].height};100x80"

		agent
			.get(URL)
			.query({
				size: size
			})
			.end (err, res) ->
				expect(res.status).to.equal(200)
				done()

	xit 'should select products by color', (done) ->
		c = product.vars[0].colors[0].key
		# console.log c
		agent
			.get( "#{URL}/?color=#{c}") 		# TODO: better way to pass get params
			.end (err,res)->
				expect(res.status).to.equal(200)
				# console.log res.body
				done()





