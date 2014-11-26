PWD 	= process.env.PWD
_ 		= require('lodash')
expect 	= require('chai').expect
sinon 	= require('sinon')

conf = require("#{PWD}/server/config/config")

prodsUrl = "#{conf.apiUrl}/store/products"
catsUrl = "#{conf.apiUrl}/store/categories"

# db = require('monk')(conf.db)
# collProducts = db.get('products')


superagent = require('superagent')
agent = superagent.agent()


# dataGenerator = require('../data/productsGenerator')
# _data = dataGenerator.getProducts(0,10)
#
# _products = null


MongoClient = require('mongodb').MongoClient
dbConn = null
collProducts = null
DataGenerator = require("#{PWD}/tools/DummyDataGenerator/dataGenerator")


describe 'api products upsert functionality', ->

	before (done) ->
		MongoClient.connect conf.db, (err, db) ->
			expect( err ).to.be.null

			dbConn = db
			collProducts = db.collection('products')
			done()

	after (done) ->
		dbConn.close()
		done()


	it 'should insert a single product to default category', (done) ->
		pData = DataGenerator.getProducts(1)
		agent
			.post( prodsUrl )
			.send( pData )
			.end (err, res) ->
				expect( err ).to.be.null
				expect(res.status).to.equal(200)
				expect(res.body).to.have.length( 1 )
				pid = res.body[0]

				agent.get( "#{prodsUrl}/#{pid}").end ( err, res) ->
					expect( err ).to.be.null
					console.log res.body.cats
					done()