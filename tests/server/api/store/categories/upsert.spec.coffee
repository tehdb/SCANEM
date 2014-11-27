PWD 	= process.env.PWD
_ 		= require('lodash')
expect 	= require('chai').expect
sinon 	= require('sinon')

conf = require("#{PWD}/server/config/config")

prodsUrl = "#{conf.apiUrl}/store/products"
catsUrl = "#{conf.apiUrl}/store/categories"

# db = require('monk')(conf.db)
# collProducts = db.get('products')

mongodb = require('mongodb')
ObjectID = mongodb.ObjectID
MongoClient = mongodb.MongoClient

superagent = require('superagent')
agent = superagent.agent()


describe.only 'api categories upsert functionality', ->

	# before (done) ->
	# 	agent.post(catsUrl).send(catData).end (err, res) ->
	# 		expect( err ).to.be.null
	# 		expect(res.status).to.equal(200)
	# 		cat = res.body
	# 		done()

	# after (done) ->
	# 	done()


	# xit 'should select a category by id', (done) ->
	# 	url = "#{catsUrl}/5475fccceadcd30000d2bb60"
	# 	agent.get(url).end (err, res) ->
	# 			expect( err ).to.be.null
	# 			# console.log res.body
	# 			done()
	catsRaw = [
		{
			name: 'Testcategory 1'
		}, {
			name: 'Testcategory 2'
		}
	]
	catObj = null
	catsArr = []

	dbConn = null
	collCats = null

	before (done) ->
		MongoClient.connect conf.db, (err, db) ->
			expect( err ).to.be.null

			dbConn = db
			collCats = db.collection('categories')
			done()

			# agent.post(catsUrl).send( catsRaw[0] ).end (err, res) ->
			# 	expect( err ).to.be.null
			# 	expect(res.status).to.equal(200)
			# 	cat = res.body[0]

			# 	expect( cat._id ).to.exist

			# 	catsArr.push( cat )
			# 	done()



	after (done) ->
		bulk = collCats.initializeUnorderedBulkOp()
		_.each catsArr, (cat) ->
			bulk.find( {_id: new ObjectID(cat._id) } ).removeOne()
		bulk.execute (err, rep) ->
			expect( err ).to.be.null
			expect( rep.nRemoved ).to.equal( catsArr.length )
			dbConn.close()
			done()

	it 'should create a new category', (done) ->
		agent.post(catsUrl).send( catsRaw[1] ).end (err, res) ->
			expect( err ).to.be.null
			expect(res.status).to.equal(200)
			cat = res.body[0]

			expect( cat._id ).to.exist

			catsArr.push( cat )
			done()

	# it 'should update a category', (done) ->
	# 	c = catsArr[0]



	# 	agent
	# 		.put( URL )
	# 		.send( p )
	# 		.end (err, res) ->
	# 			expect(res.status).to.equal 200
	# 			expect(res.body.title).to.equal p.title
	# 			done()

	# beforeEach (done) ->
	# 	agent.post(catsUrl).send(catData).end (err, res) ->
	# 		expect( err ).to.be.null
	# 		expect(res.status).to.equal(200)
	# 		console.log res.body
	# 		done()

	# afterEach (done) ->


	# it 'should create a new category', (done) ->
	# it 'should not create a category if data is invalid', ->
	# 	agent.post(catsUrl).send(catData).end (err, res) ->
	# 		expect( err ).to.be.null
	# 		# expect(res.status).to.equal(200)
	# 		done()


	# it 'it should update a category', (done) ->

	# it 'should not create a category if data is invalid', ->
	# 	agent.post(catsUrl).send(catData).end (err, res) ->
	# 		expect( err ).to.be.null
	# 		# expect(res.status).to.equal(200)
	# 		done()
