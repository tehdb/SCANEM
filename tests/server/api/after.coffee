_ = require('lodash')
mongoose = require('mongoose')
expect 	= require('chai').expect

describe 'stop server', ->

	catsRaw = global.CONF().dataGenerator.getCats()

	models = {}
	# CategoryModel = null
	# ProductModel = null

	before (done) ->
		models.cat = mongoose.model('Category')
		models.prod = mongoose.model('Product')
		models.user = mongoose.model('User')

		done()


	it 'should remove test products', (done) ->
		query = new RegExp('Test Product.*', 'i')

		bulk = models.prod.collection.initializeUnorderedBulkOp()
		bulk.find({ title: query}).remove()
		bulk.execute (err, rep) ->
			expect(err).to.be.null
			done()


	it 'should remove test categories', (done) ->
		bulk = models.cat.collection.initializeUnorderedBulkOp()
		_.each catsRaw, (cat) -> bulk.find({name: cat.name}).removeOne()
		bulk.execute (err, rep) ->
			expect(err).to.be.null
			done()


	it 'should remove no more existed products from categories items arrays', (done) ->
		models.cat.cleanUpAll( done )


	it 'should remove test users', (done) ->
		userRaw = global.CONF().dataGenerator.getUsers()

		bulk = models.user.collection.initializeUnorderedBulkOp()

		_.each userRaw, (user) -> bulk.find({email: user.email}).removeOne()
		bulk.execute (err, rep) ->
			expect(err).to.be.null
			done()

