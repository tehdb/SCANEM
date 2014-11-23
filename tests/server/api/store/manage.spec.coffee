PWD 	= process.env.PWD
_ 		= require('lodash')
expect 	= require('chai').expect
sinon 	= require('sinon')

conf = require("#{PWD}/server/config/config")

db = require('monk')(conf.db)
productsCollection = db.get('products')

URL = "#{conf.apiUrl}/store/products"

superagent = require('superagent')
agent = superagent.agent()


_data = require('../data/products')
_products = null



describe.only 'api products manager', ->


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
		productsCollection.remove {ean: {$in: eans}}, (err ) ->
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

	it 'should select products by single color', (done) ->
		p = _products[0]
		c = p.colors[0].key

		agent
			.get( "#{URL}")
			.query( { color: c } )	# get params
			.end (err,res)->
				expect(res.status).to.equal(200)

				_.each res.body, (p) ->
					idx = _.findIndex p.colors, (v) -> return v.key is c
					expect(idx).to.be.above(-1)

				done()

	it 'should select products by multiple colors', (done) ->
		p = _.find _products, (p) -> p.colors.length > 1
		# p = _products[0]
		c1 = p.colors[0].key
		c2 = p.colors[1].key
		colors = "#{c1};#{c2}"

		agent
			.get( "#{URL}")
			.query( { color: colors } )	# get params
			.end (err,res)->
				expect(res.status).to.equal(200)

				_.each res.body, (p) ->
					idx = _.findIndex p.colors, (v) -> return v.key is c1 or v.key is c2
					expect(idx).to.be.above(-1)

				done()

	it 'should select products by single size', (done) ->
		p = _products[0]
		s = p.sizes[0]
		size = "#{s.width}x#{s.height}"

		agent
			.get( "#{URL}")
			.query( { size: size } )	# get params
			.end (err,res)->
				expect(res.status).to.equal(200)

				_.each res.body, (p) ->
					idx = _.findIndex p.sizes, (v) -> v.width is s.width and v.height is s.height
					expect(idx).to.be.above(-1)

				done()

	it 'should select products by multiple sizes', (done) ->
		p = _.find _products, (p) -> p.sizes.length > 1
		s1 = p.sizes[0]
		s2 = p.sizes[1]
		sizes = "#{s1.width}x#{s1.height};#{s2.width}x#{s2.height}"

		agent
			.get( "#{URL}")
			.query( { size: sizes } )	# get params
			.end (err,res)->
				expect(res.status).to.equal(200)

				_.each res.body, (p) ->
					idx = _.findIndex p.sizes, (v) ->
						(v.width is s1.width and v.height is s1.height) or
						(v.width is s2.width and v.height is s2.height)
					expect(idx).to.be.above(-1)

				done()


	it 'should select products by size and color', (done) ->
		p = _.find _products, (p) -> p.sizes.length > 1 and p.colors.length > 1

		s1 = p.sizes[0]
		s2 = p.sizes[1]
		sizes = "#{s1.width}x#{s1.height};#{s2.width}x#{s2.height}"

		c1 = p.colors[0].key
		c2 = p.colors[1].key
		colors = "#{c1};#{c2}"

		agent
			.get( "#{URL}")
			.query( { size: sizes, color: colors } )	# get params
			.end (err,res)->
				expect(res.status).to.equal(200)

				_.each res.body, (p) ->
					sizeIdx = _.findIndex p.sizes, (v) ->
						(v.width is s1.width and v.height is s1.height) or
						(v.width is s2.width and v.height is s2.height)

					colorIdx = _.findIndex p.colors, (v) -> return v.key is c1 or v.key is c2

					expect(sizeIdx).to.be.above(-1)
					expect(colorIdx).to.be.above(-1)

				done()







