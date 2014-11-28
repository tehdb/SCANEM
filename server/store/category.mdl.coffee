_ = require('lodash')
mongoose = require('mongoose')
Schema = mongoose.Schema

schemaName = 'Category'

errLog = require('winston').loggers.get( 'error' )

schema = new Schema(
	name:
		type: 		String
		required: 	true
		unique: 	true
		index: 		true

	#
	# default
	#
	# cat
	# subcat
	#
	#
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

schema.pre 'save', (next, done) ->
	c = @

	# err = new Error('something went wrong');
	# next(err);
	# console.log "pre save"

	next()

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
	getDefault: (cb) ->
		c = @

		c.findOne {name: global.conf.defaults.category.name}, (err, cat) ->
			return cb?(err) if err
			return cb?('no default categiry set') if !cat?

			cb?(null, cat)

	ensureDefaults: (cat, cb) ->
		c = @

		defCatRaw = global.CONF().defaults.category
		c.create defCatRaw, (err, doc) ->
			errLog.error( err ) if err and err.code isnt 11000




	addProdsToCats: ( pArr, cb ) ->
		c = @

		bulk = c.initializeUnorderedBulkOp()


		_.each pArr, (p) ->
			bulk.find({_id:catId}).updateOne( {$push: {items: p._id} } )

		bulk.execute ->
			cb?(null)


		# _.each pArr, (p) ->
		# 	_.each p.cats, (catId) ->
		# 		c.findOne {_id: catId}, (err, cat) ->
		# 			return cb?(err) if err

		# c.findOne {_id: catId}, (err, cat) ->
		# 	return cb?(err) if err
		# 	return cb?("no categiry found for id #{catId}") if !cat?

		# 	cat.items.push(prodIt)

		# 	cat.save (err, cat) ->
		# 		return cb?(err) if err

		# 		cb?(cat)



# CUSTOM INSTANCE METHODS
# schema.methods =

module.exports = mongoose.model(schemaName, schema)
