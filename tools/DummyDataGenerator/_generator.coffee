PWD 	= process.env.PWD
_ = require('lodash')

MongoClient = require('mongodb').MongoClient
EventEmitter 	= require('events').EventEmitter
pubsub 			= new EventEmitter()
stdio = require('stdio')


CONF = require("#{PWD}/server/config/config")

CATS =[
	{ name: 'Testcat' },
	{ name: 'Philander' },
	{ name: 'Antipater' },
	{ name: 'Itxaro' },
	{ name: 'Victorina' },
	{ name: 'Winoc' },
	{ name: 'Prometheus' },
	{ name: 'Branislava' }
]

class Supplier
	constructor: (@conf) ->
		c = @

		c.gen = require('./dataGenerator')
		c.db = null
		c.cats = null
		c.prods = null
		# c.openConnection ->
		# 	c.insertCats ->
		# 		c.closeConnection()
		c.initListeners()
		c.openConnection()

	initListeners: ->
		c = @
		pubsub.on 'DatabaseConnectedEvent', ->
			c.insertCats()

		pubsub.on 'CatsCreatedEvent', (cats) ->
			c.cats = cats
			c.insertPords()

		pubsub.on 'ProdsCreatedEvent', (prods) ->
			c.closeConnection()

		pubsub.on 'ErrorOccurredEvent', (err) ->
			console.log err
			c.closeConnection()
			process.exit(1)


	insertCats: (cb) ->
		c = @

		c.db.collection('categories').insert CATS, (err, cats) ->
			return pubsub.emit('ErrorOccurredEvent', err) if err

			pubsub.emit('CatsCreatedEvent', cats)

	insertPords: (cb) ->
		c = @

		prodsDataArr = c.gen.getProducts(3)


		prods = _.each prodsDataArr, (p) ->
			pCatIds = _.shuffle( _.pluck( c.cats, '_id' ) ).slice(0, _.random(1, 3))#c.cats.length))
			p.cats = pCatIds


		c.db.collection('products').insert prods, (err, prods) ->
			return pubsub.emit('ErrorOccurredEvent', err) if err
			c.prods = prods
			pubsub.emit('ProdsCreatedEvent')


	openConnection: (cb) ->
		c = @

		MongoClient.connect CONF.db, (err, db) ->
			return pubsub.emit('ErrorOccurredEvent', err) if err
			c.db = db
			pubsub.emit('DatabaseConnectedEvent')
			cb?()

	closeConnection: ->
		@db.close()

class Cleaner
	constructor: ->
		c = @

		c.db = null
		c.cats = null

		# c.initListeners()

		c.openConnection ->
			c.removeCats (err, cats) ->
				return c.exit(err) if err

				console.log cats
				c.exit(null, "no errors")



	initListeners: ->
		c = @
		pubsub.on 'DatabaseConnectedEvent', ->
			c.removeCats()

		pubsub.on 'CatsRemovedEvent', (cats) ->
			c.cats = cats
			# console.log cats
			# c.insertPords()
			c.closeConnection()

		pubsub.on 'ProdsRemovedEvent', (prods) ->
			c.closeConnection()

		pubsub.on 'ErrorOccurredEvent', (err) ->
			console.log err
			c.closeConnection()
			process.exit(1)

	removeCats: (cb) ->
		c = @

		c.db.collection('categories').find {name: {$in: _.pluck(CATS, 'name')}}, (err, cats) ->
			# return pubsub.emit('ErrorOccurredEvent', err) if err
			return cb?(err) if err

			console.log cats

			c.db.collection('categories').remove {name: {$in: _.pluck(CATS, 'name')}}, (err) ->
				return cb?(err) if err
				# return pubsub.emit('ErrorOccurredEvent', err) if err
				# pubsub.emit('CatsRemovedEvent', cats)
				cb?(null, cats)


	# removePords: (cb) ->
	# 	c = @


	openConnection: (cb) ->
		c = @
		MongoClient.connect CONF.db, (err, db) ->
			return pubsub.emit('ErrorOccurredEvent', err) if err
			c.db = db
			pubsub.emit('DatabaseConnectedEvent')
			cb?()

	exit: (err, msg) ->
		c = @

		c.db.close()

		if err
			console.log err
			process.exit(1)

		if msg
			console.log msg

		process.exit(0)


ops = stdio.getopt({
	'supply' : { key: 's', description: 'fill the db with test data'}
	'clear' : { key: 'c', description: 'remove test data from db'}
})

# console.log ops

if ops.supply
	new Supplier()

else if ops.clear
	new Cleaner()

#
	# collCats = db.collection('categories')
	# collProds = db.collection('products')






	#for c in cats


# prodsGen = 	require('./prodGenerator')
# gen = 	require('./dataGenerator')



# gen.getRandomCats(), (item) -> console.log item["_id"]

# catIds =  _.pluck( gen.getRandomCats(), '_id' )


# console.log catIds

# console.log JSON.stringify( gen.getProducts(1), null, '\t' )
# for i in [0..10]
# 	console.log catsGen.getRandomCats(1)
	# console.log "***"
	# console.log catsGen.getRandomCats().length + " " + catsGen.getRandomCats(1).length
	# console.log "***"
# console.log prodsGen.getProducts(0,0)