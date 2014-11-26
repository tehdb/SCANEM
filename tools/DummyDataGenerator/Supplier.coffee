
_ = require('lodash')

class Supplier
	constructor: (@conf) ->
		c = @
		c.gen = require('./dataGenerator')
		c.db = null

		c.conf.pCount = c.conf.pCount or 100

	supply: ->
		c = @
		c.openConnection (err, db) ->
			return c.exit(err) if err

			c.db = db

			c.insertCats (err, cats) ->
				return c.exit(err) if err

				c.cats = cats

				c.insertPords (err, prods) ->
					return c.exit(err) if err

					c.prods = prods

					report = "
						#{cats.length} categories created\n\
						#{prods.length} products created
					"

					c.exit(null, report)


	insertCats: (cb) ->
		c = @

		c.db.collection('categories').insert c.conf.cats, (err, cats) ->
			return cb?(err) if err
			cb?(null, cats)

	insertPords: (cb) ->
		c = @

		prodsDataArr = c.gen.getProducts(c.conf.pCount)


		prods = _.each prodsDataArr, (p) ->
			pCatIds = _.shuffle( _.pluck( c.cats, '_id' ) ).slice(0, _.random(1, 3))#c.cats.length))
			p.cats = pCatIds


		c.db.collection('products').insert prods, (err, prods) ->
			return cb?(err) if err
			cb?(null, prods)


	openConnection: (cb) ->
		c = @
		MongoClient = require('mongodb').MongoClient
		MongoClient.connect c.conf.db, (err, db) ->
			return cb?(err) if err
			cb?(null, db)

	exit: (err, msg) ->
		c = @

		c.db.close()

		if err
			console.log err
			process.exit(1)

		if msg
			console.log msg

module.exports = Supplier