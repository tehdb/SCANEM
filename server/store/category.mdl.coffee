_ = require('lodash')
q = require('q')
mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = mongoose.Types.ObjectId
schemaName = 'Category'

errLog = require('winston').loggers.get( 'error' )

schema = new Schema(
	name:
		type: 		String
		required: 	true
		unique: 	true
		index: 		true

	type:
		type: String
		enum: [ 'default', 'cat', 'subcat' ]
		default: 'cat'

	# parentId:
	# 	type: Schema.Types.ObjectId
	# 	ref: 'Product'

	descriptions:
		type: String

	items:
		type: [{
			type: Schema.Types.ObjectId
			ref: 'Product'
			unique: true
		}]
		default: []
)


schema.pre 'remove', (next) ->
	c = @

	catMdl = c.model( schemaName )

	moveItemsToDefault = ->

		catMdl.find {type: 'default'}, (err, cats) ->
			return next(err) if err

			bulk = 	catMdl.collection.initializeUnorderedBulkOp()
			_.each cats, (cat) ->
				_.each c.items, (itemId) ->
					bulk.find({_id:cat._id}).updateOne( {$addToSet: {items: itemId} } )

			try
				bulk.execute (err, rep) ->
					return next(err) if err
					next()

			catch err
				next(err)


	if c.type is 'default'
		catMdl.find {type: 'default'}, (err, docs) ->
			return next(err) if err

			if docs.length <= 1 and String(c._id) is String(docs[0]._id)
				err = new Error()
				err.reason = 'Can not remove last default category'
				err.status = 409
				next( err )
			else
				moveItemsToDefault()
	else
		moveItemsToDefault()
		# next()


	# console.log "pre remove"

	# next()


# CUSTOM STATIC METHODS
schema.statics =

	ensureDefaults: (cat, cb) ->
		c = @

		defCatRaw = global.CONF().defaults.category
		c.create defCatRaw, (err, doc) ->
			errLog.error( err ) if err and err.code isnt 11000


	cleanUpAll: (cb) ->
		c = @
		CategoryModel = c.model( schemaName )

		CategoryModel.find {}, (err, cats) ->
			return errLog.error( err ) if err

			promises = []
			_.each cats, (cat) -> promises.push( cat.cleanUp() ) if cat.items.length > 0

			q.all(promises).spread (rep...) -> cb?()


# CUSTOM INSTANCE METHODS
schema.methods =
	cleanUp: ->
		c = @
		# resolve null if items array is empty
		if c.items.length <= 0
			return q.fcall -> return null

		def = q.defer()

		ProductModel = require('mongoose').model('Product')

		promises = []
		_.each c.items, (item) -> promises.push(ProductModel.isPresent(item))

		q.allSettled(promises).then (zombies...) ->
			zombies = _.pluck( _.filter(zombies[0], (z) -> return z.state is 'rejected'), 'reason')

			zombiesSize = zombies.length - 1
			_.each zombies, (z, idx) ->
				c.update { $pull: { items: z }}, (err, count) ->
					errLog.error( err ) if err
					if idx is zombiesSize
						c.model( schemaName ).findOne { _id:c._id}, (err, doc) ->
							if err then def.reject(err) else def.resolve( doc )

		return def.promise


module.exports = mongoose.model(schemaName, schema)
