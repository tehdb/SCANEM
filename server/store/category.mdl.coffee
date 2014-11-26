_ = require('lodash')
mongoose = require('mongoose')
Schema = mongoose.Schema

schemaName = 'Category'

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
		}]
		default: []
)


# CUSTOM STATIC METHODS
schema.statics =
	getDefault: (cb) ->
		c = @

		c.findOne {name: global.conf.defaults.category.name}, (err, cat) ->
			return cb?(err) if err
			return cb?('no default categiry set') if !cat?

			cb?(null, cat)

	setDefault: (cat, cb) ->
		c = @

		c.create cat, (err, doc) ->
			if err and err.code isnt 11000
				console.log err.code


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
