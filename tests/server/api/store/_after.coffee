_ = require('lodash')
mongoose = require('mongoose')
expect 	= require('chai').expect

describe 'stop server', ->

	catsRaw = global.CONF().dataGenerator.getCats()
	# dbModels = {}
	CategoryModel = null
	ProductModel = null

	before (done) ->
		CategoryModel = mongoose.model('Category')
		ProductModel = mongoose.model('Product')

		done()


	it 'should remove no more existed products from categories items arrays', (done) ->
		CategoryModel.cleanUpAll done


	it 'should remove test categories', (done) ->
		bulk = CategoryModel.collection.initializeUnorderedBulkOp()
		_.each catsRaw, (cat) -> bulk.find({name: cat.name}).removeOne()
		bulk.execute (err, rep) ->
			expect(err).to.be.null
			done()

		# done()
		# ProductModel.findOne {_id: '547c37e5b9c1811309ddfc96'}, (err, prod) ->
		# 	console.log err
		# 	console.log prod
		# 	done()

	# it 'should clean up', (done) ->
		# done()