_ = require('lodash')
mongoose = require('mongoose')
expect 	= require('chai').expect

describe 'stop server', ->

	catsRaw = global.CONF().dataGenerator.getCats()

	CategoryModel = null
	ProductModel = null

	before (done) ->
		CategoryModel = mongoose.model('Category')
		ProductModel = mongoose.model('Product')

		done()


	it 'should remove test products', (done) ->
		query = new RegExp('Test Product.*', 'i')

		bulk = ProductModel.collection.initializeUnorderedBulkOp()
		bulk.find({ title: query}).remove()
		bulk.execute (err, rep) ->
			expect(err).to.be.null
			done()


	it 'should remove test categories', (done) ->
		bulk = CategoryModel.collection.initializeUnorderedBulkOp()
		_.each catsRaw, (cat) -> bulk.find({name: cat.name}).removeOne()
		bulk.execute (err, rep) ->
			expect(err).to.be.null
			done()


	it 'should remove no more existed products from categories items arrays', (done) ->
		CategoryModel.cleanUpAll( done )

