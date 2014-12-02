PWD 	= process.env.PWD
_ 		= require('lodash')
expect 	= require('chai').expect
# sinon 	= require('sinon')


mongodb = require('mongodb')
ObjectID = mongodb.ObjectID
mongoose = require('mongoose')

superagent = require('superagent')
agent = superagent.agent()


describe 'api products', ->

	prodsUrl = "#{global.CONF().apiUrl}/store/products"
	dataGenerator = global.CONF().dataGenerator
	models = {}		# database models


	before (done) ->
		models.prod = mongoose.model('Product')
		done()


	it 'should insert a single product to default category', (done) ->
		pData = dataGenerator.getProds(1)
		agent
			.post( prodsUrl )
			.send( pData )
			.end (err, res) ->
				expect(res.status).to.equal(200)

				prod = res.body[0]

				expect( prod._id).to.exist

				done()


	it 'should inser mutliple products', (done) ->
		psData = dataGenerator.getProds(6)
		agent
			.post( prodsUrl )
			.send( psData )
			.end (err, res) ->
				expect(res.status).to.equal(200)
				expect( res.body ).to.have.length( psData.length )
				done()


	it 'should update a product', (done) ->
		models.prod.findOne {}, (err, p) ->
			expect( err ).to.be.null
			p.title += ' UPDATED'

			agent
				.put( prodsUrl )
				.send( p )
				.end (err, res) ->
					expect(res.status).to.equal 200
					expect(res.body.title).to.equal p.title
					done()


	it 'should select one product by id', (done) ->
		models.prod.findOne {}, (err, p) ->
			expect( err ).to.be.null

			pid = String(p._id)

			agent
				.get( "#{prodsUrl}/#{pid}")
				.end (err, res) ->
					expect(res.status).to.equal(200)
					expect(res.body._id).to.equal pid
					done()


	it 'should select products by single color', (done) ->
		models.prod.findOne {}, (err, p) ->
			expect( err ).to.be.null

			# p = prodsArr[0]
			c = p.colors[0].key

			agent
				.get( "#{prodsUrl}")
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
		models.prod.findOne { $where: 'this.colors.length>1' }, (err, p) ->
			expect( err ).to.be.null

			c1 = p.colors[0].key
			c2 = p.colors[1].key
			colors = "#{c1};#{c2}"

			agent
				.get( "#{prodsUrl}")
				.query( { color: colors } )	# get params
				.end (err,res)->
					expect(res.status).to.equal(200)

					_.each res.body, (p) ->
						idx = _.findIndex p.colors, (v) -> return v.key is c1 or v.key is c2
						expect(idx).to.be.above(-1)

					done()

	it 'should select products by single size', (done) ->
		models.prod.findOne {}, (err, p) ->
			expect( err ).to.be.null

			s = p.sizes[0]
			size = "#{s.width}x#{s.height}"

			agent
				.get( "#{prodsUrl}")
				.query( { size: size } )
				.end (err,res)->
					expect(res.status).to.equal(200)

					_.each res.body, (p) ->
						idx = _.findIndex p.sizes, (v) -> v.width is s.width and v.height is s.height
						expect(idx).to.be.above(-1)

					done()

	it 'should select products by multiple sizes', (done) ->
		models.prod.findOne { $where: 'this.sizes.length>1' }, (err, p) ->
			expect( err ).to.be.null

			s1 = p.sizes[0]
			s2 = p.sizes[1]
			sizes = "#{s1.width}x#{s1.height};#{s2.width}x#{s2.height}"

			agent
				.get( "#{prodsUrl}")
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
		models.prod.findOne { $where: "this.sizes.length > 1 && this.colors.length > 1"}, (err, p) ->
			expect( err ).to.be.null

			s1 = p.sizes[0]
			s2 = p.sizes[1]
			sizes = "#{s1.width}x#{s1.height};#{s2.width}x#{s2.height}"

			c1 = p.colors[0].key
			c2 = p.colors[1].key
			colors = "#{c1};#{c2}"

			agent
				.get( "#{prodsUrl}")
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
			.get( "#{prodsUrl}")
			.query( { limit: 3 } )
			.end (err,res)->
				expect(res.status).to.equal(200)
				expect(res.body).to.have.length( 3 )
				done()

	# TODO: add more then
	it 'should paginate', (done) ->
		page1 = null
		page2 = null

		agent
			.get( "#{prodsUrl}")
			.query( { limit: 3, page: 0 } )
			.end (err,res)->
				expect(res.status).to.equal(200)
				page1 = res.body
				expect(page1).to.have.length( 3 )

				agent
					.get( "#{prodsUrl}")
					.query( { limit: 3, page: 1 } )
					.end (err,res)->
						expect(res.status).to.equal(200)
						page2 = res.body
						expect(page2).to.have.length( 3 )

						# page1 should no contain the same products as page2
						expect(_.where(page2, p)).to.have.length(0) for p in page1

						done()


	it 'should select products by query', (done) ->
		agent
			.get ("#{prodsUrl}")
			.query( {q: "Test Product"})
			.end (err,res)->
				expect(res.status).to.equal(200)
				expect( res.body ).to.have.length.above(6)
				done()


	# TODO:
	xit 'should select products for category', (done) ->

		done()












