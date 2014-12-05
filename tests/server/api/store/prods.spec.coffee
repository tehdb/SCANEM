_ 		= require('lodash')
expect 	= require('chai').expect
# sinon 	= require('sinon')


# mongodb = require('mongodb')
# ObjectID = mongodb.ObjectID
mongoose = require('mongoose')

superagent = require('superagent')
agent = superagent.agent()


describe 'api products', ->

	prodsUrl = "#{global.CONF().apiUrl}/store/products"
	dataGenerator = global.CONF().dataGenerator
	models = {}		# database models


	before (done) ->
		models.prod = mongoose.model('Product')
		models.cat = mongoose.model('Category')
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
		models.prod.findOne { attrs: { $elemMatch: { key: 'color' } } }, (err, p) ->
			expect( err ).to.be.null

			c = _.find p.attrs, (a) -> return a.key is 'color'
			c = c.val

			agent
				.get( "#{prodsUrl}")
				.query( { color: c } )	# get params
				.end (err,res)->
					expect(res.status).to.equal(200)
					_.each res.body, (p) ->
						idx = _.findIndex p.attrs, (a) -> a.key is 'color' and a.val is c
						expect(idx).to.be.above(-1)
					done()


	it 'should select products where any color in the list', (done) ->

		# where attrs colors lenght more then one
		queryFn = ->
			colors = []
			for a in this.attrs
				colors.push( a ) if a.key is 'color'
			return colors.length > 1

		models.prod.findOne {$where: queryFn }, (err, p) ->
			colors = _.pluck( _.filter( p.attrs, (a) -> return a.key is 'color' ), 'val' )

			agent
				.get( "#{prodsUrl}")
				.query( { color: colors.join(';') } )	# get params
				.end (err,res)->
					expect(res.status).to.equal(200)

					_.each res.body, (p) ->
						pColors = _.pluck( _.filter( p.attrs, (a) -> return a.key is 'color' ), 'val' )
						expect( _.intersection(pColors, colors ) ).to.have.length.above(0)
					done()


	it 'should select products by single size', (done) ->
		query =
			$and: [
				{ attrs: { $elemMatch: { key: 'width' } } },
				{ attrs: { $elemMatch: { key: 'height' } } }
			]

		models.prod.findOne query, (err, p) ->
				expect( err ).to.be.null

				raw =
					w : (_.find p.attrs, (a) -> return a.key is 'width').val
					h : (_.find p.attrs, (a) -> return a.key is 'height').val

				agent
					.get( "#{prodsUrl}")
					.query( { size: "#{raw.w}x#{raw.h}" } )
					.end (err,res)->

						expect(res.status).to.equal(200)

						_.each res.body, (p) ->
							wIdx = _.indexOf( _.pluck( _.filter(p.attrs, (a) -> return a.key is 'width'), 'val' ), raw.w )
							hIdx = _.indexOf( _.pluck( _.filter(p.attrs, (a) -> return a.key is 'height'), 'val' ), raw.h )

							expect(wIdx).to.be.above(-1)
							expect(hIdx).to.be.above(-1)

						done()


	xit 'should select products by multiple sizes', (done) ->
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


	xit 'should select products by size and color', (done) ->
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
			.get("#{prodsUrl}")
			.query( {q: "Test Product"})
			.end (err,res)->
				expect(res.status).to.equal(200)
				# there must be above 6 products in the db from upper tests
				expect( res.body ).to.have.length.above(6)
				done()


	it 'should select products for category', (done) ->
		models.cat.findOne { $where: 'this.items.length>1' }, (err, cat) ->
			agent
				.get(prodsUrl)
				.query( {cat: String(cat._id)} )
				.end (err,res)->

					# console.log res.body.length + " " + cat.items.length
					expect(res.status).to.equal(200)
					expect( res.body ).to.have.length( cat.items.length )
					done()












