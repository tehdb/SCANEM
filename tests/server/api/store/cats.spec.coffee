PWD 	= process.env.PWD
_ 		= require('lodash')
expect 	= require('chai').expect
# sinon 	= require('sinon')


mongodb = require('mongodb')
ObjectID = mongodb.ObjectID
mongoose = require('mongoose')

superagent = require('superagent')
agent = superagent.agent()

# prodsUrl = "#{global.CONF().apiUrl}/store/products"
catsUrl = "#{global.CONF().apiUrl}/store/categories"


describe 'api categories', ->

	# catsRaw = [
	# 	{
	# 		name: 'Testcategory 1'
	# 	}, {
	# 		name: 'Testcategory 2'
	# 	}
	# ]
	catsRaw = global.CONF().dataGenerator.getCats()
	catsArr = []
	dbModels = {}

	# console.log catsRaw

	before (done) ->
		dbModels.cat = mongoose.model('Category')
		done()


	it 'should create a new category', (done) ->
		agent.post(catsUrl).send( catsRaw[0] ).end (err, res) ->
			expect(res.status).to.equal(200)
			cat = res.body[0]

			expect( cat._id ).to.exist

			catsArr.push( cat )
			done()


	it 'should create another category', (done) ->
		agent.post(catsUrl).send( catsRaw[1] ).end (err, res) ->
			expect(res.status).to.equal(200)
			cat = res.body[0]

			expect( cat._id ).to.exist
			catsArr.push( cat )
			done()


	it 'should not create category if parameters are invalid', (done) ->
		agent.post(catsUrl).send({}).end (err, res) ->
			expect(res.status).to.equal(400)
			done()


	it 'should update a category', (done) ->
		c = catsArr[0]
		c.name += " UPDATED"
		c.items = [new ObjectID(), new ObjectID()]

		agent.put( catsUrl ).send( c ).end (err, res) ->
			cat = res.body.name
			expect( c.name ).to.equal( c.name )
			expect( c.items ).to.have.length( c.items.length )
			done()


	it 'should select category by id', (done) ->
		c = catsArr[0]

		agent.get( "#{catsUrl}/#{c._id}" ).end (err, res) ->
			expect(res.status).to.equal(200)
			expect( res.body._id ).to.equal( c._id )
			done()


	it 'should select categoie by query', (done) ->
		c = catsArr[0]
		q = c.name.substr( 0, 7 )

		agent.get( "#{catsUrl}").query( {q:q} ).end (err, res) ->
			expect(res.status).to.equal(200)
			expect(res.body).to.have.length.above(0)
			done()


	it 'should select the list of all categories', (done) ->
		agent.get(catsUrl).end (err, res) ->
			expect(res.status).to.equal(200)
			expect(res.body).to.have.length.above(2)
			done()


	it 'should remove a category and move its items to default', (done) ->
		c = catsArr[0]

		delCatItems = []
		_.every c.items, (item, idx) -> delCatItems[idx] = String(item)

		agent.del( catsUrl ).send( c ).end (err, res) ->
			expect(res.status).to.equal(200)

			# check if items were moved to default
			dbModels.cat.find {type: 'default'}, (err, defCats) ->
				expect(err).to.be.null

				res = _.every defCats, (defCat) ->
					defCatItems = []
					_.every defCat.items, (item, idx) -> defCatItems[idx] = String(item)
					return _.intersection( defCatItems, delCatItems).length is delCatItems.length

				expect( res ).to.be.true
				done()


	it 'should not remove a last default category', (done) ->
		dbModels.cat.findOne { type : 'default' }, (err, doc) ->
			expect(doc).to.be.an('object')
			expect(doc._id).to.exist

			agent.del( catsUrl ).send( doc ).end (err, res) ->
				expect(res.status).to.equal(409)
				done()
