PWD 	= process.env.PWD
_ 		= require('lodash')
expect 	= require('chai').expect
sinon 	= require('sinon')

conf = require("#{PWD}/server/config/config")

# db = require('monk')(conf.db)
# collProducts = db.get('products')

URL = "#{conf.apiUrl}/store/products"

superagent = require('superagent')
agent = superagent.agent()


dataGenerator = require('../data/productsGenerator')
# _data = dataGenerator.getProducts(0,10)
_products = null


MongoClient = require('mongodb').MongoClient
dbConn = null
collProducts = null


describe.only 'api products manager', ->

	# insert multiple prdocuts
	before (done) ->
		MongoClient.connect conf.db, (err, db) ->
			expect( err ).to.be.null

			dbConn = db
			collProducts = db.collection('products')

			pDataArr = dataGenerator.getProducts(0,100)

			bulk = collProducts.initializeUnorderedBulkOp()
			bulk.insert(pData) for pData in pDataArr
			bulk.execute( done )


			# collProducts.insert pDataArr, (err, pArr...) ->
			# 	expect( err ).to.be.null
			# 	# console.log pArr
			# 	done()

	# clean up - remove products from db
	after (done) ->
		bulk = collProducts.initializeUnorderedBulkOp()
		bulk.find( {cats: {$elemMatch: { $eq: 'testcat'}}} ).remove()
		bulk.execute( ->
			dbConn.close()
			done()
		)



	it 'should insert a single product', (done) ->
		pData = dataGenerator.getProducts(101,101)[0]
		agent
			.post( URL )
			.send( pData )
			.end (err, res) ->
				expect(res.status).to.equal(200)
				expect(res.body).to.have.length( 1 )
				done()


	it 'should update a product', (done) ->
		collProducts.findOne {}, (err, p) ->
			expect( err ).to.be.null
			p.title += " - UPDATED"

			agent
				.put( URL )
				.send( p )
				.end (err, res) ->
					expect(res.status).to.equal 200
					expect(res.body.title).to.equal p.title
					done()


	it 'should select one product by id', (done) ->
		collProducts.findOne {}, (err, p) ->
			expect( err ).to.be.null

			agent
				.get( "#{URL}/#{p._id}")
				.end (err, res) ->
					expect(res.status).to.equal(200)
					expect(res.body._id).to.equal String(p._id)
					done()

	it 'should select products by single color', (done) ->
		collProducts.findOne {}, (err, p) ->
			expect( err ).to.be.null

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
		# p = _.find _products, (p) -> p.colors.length > 1
		# p = _products[0]
		collProducts.findOne { $where: 'this.colors.length>1' }, (err, p) ->
			expect( err ).to.be.null

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
		collProducts.findOne {}, (err, p) ->
			expect( err ).to.be.null

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
		collProducts.findOne { $where: 'this.sizes.length>1' }, (err, p) ->
			expect( err ).to.be.null

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
		# p = _.find _products, (p) -> p.sizes.length > 1 and p.colors.length > 1
		collProducts.findOne { $where: "this.sizes.length > 1 && this.colors.length > 1"}, (err, p) ->
			expect( err ).to.be.null

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

	it 'should limit the products result list', (done) ->
		agent
			.get( "#{URL}")
			.query( { limit: 3 } )
			.end (err,res)->
				expect(res.status).to.equal(200)
				expect(res.body).to.have.length( 3 )
				done()

	it 'should paginate', (done) ->
		page1 = null
		page2 = null

		agent
			.get( "#{URL}")
			.query( { limit: 3, page: 0 } )
			.end (err,res)->
				expect(res.status).to.equal(200)
				page1 = res.body
				expect(page1).to.have.length( 3 )

				agent
					.get( "#{URL}")
					.query( { limit: 3, page: 0 } )
					.end (err,res)->
						expect(res.status).to.equal(200)
						page2 = res.body
						expect(page2).to.have.length( 3 )

						expect(_.where(page2, p)).to.have.length(0) for p in page1

						done()

	it 'should select products by query', (done) ->
		agent
			.get ("#{URL}")
			.query( {q: "Product 1"})
			.end (err,res)->
				expect(res.status).to.equal(200)

				# TODO:
				# console.log res.body
				done()

	# it 'should select products for category', (done) ->
	# 	collProducts.findOne {}, (err, p) ->
	# 		expect( err ).to.be.null










