_ = require('lodash')

class Cleaner
	constructor: (@conf, @cats) ->
		c = @

		c.db = null
		c.cats = null

	clean: ->
		c = @
		c.openConnection (db) ->
			c.db = db
			c.removeCats (err, cats) ->
				return c.exit(err) if err

				c.removePords cats, (err, report) ->
					return c.exit(err) if err

					report = "
						#{cats.length} categories deleted \n\
						#{report} products deleted
					"

					c.exit(null, report)


	removeCats: (cb) ->
		c = @

		c.db.collection('categories').find({name: {$in: _.pluck(c.conf.cats, 'name')}}).toArray (err, cats) ->
			return cb?(err) if err

			c.db.collection('categories').remove {name: {$in: _.pluck(c.conf.cats, 'name')}}, (err) ->
				return cb?(err) if err
				cb?(null, cats)


	removePords: (cats, cb) ->
		c = @

		catsIds = _.pluck( cats, '_id')

		c.db.collection('products').remove { cats: $elemMatch: { $in:catsIds } }, (err, rep) ->
			return cb?(err) if err
			cb?(null, rep)

	openConnection: (cb) ->
		c = @
		MongoClient = require('mongodb').MongoClient
		MongoClient.connect c.conf.db, (err, db) ->
			return cb?(err) if err
			cb?(db)

	exit: (err, msg) ->
		c = @

		c.db.close()

		if err
			console.log err
			process.exit(1)

		if msg
			console.log msg

module.exports = Cleaner