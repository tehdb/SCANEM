_ = require('lodash')
q = require('q')
mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = mongoose.Types.ObjectId

schemaName = 'Product'

errLog = require('winston').loggers.get( 'error' )

_schema = new Schema(

	title :
		type : 		String
		required : 	true
		index: 		true

	ean :
		type : 		String
		required : 	true
		unique : 	true

	imgs:
		type: [ new Schema(
			src: String
			ori:
				type: String
				enum: ['landscape', 'portrait', 'quadratic']
			colors: [Schema.Types.ObjectId]
			sizes: [Schema.Types.ObjectId]
		)]

	colors:
		type: [ new Schema(
			key:
				type: String
				required: true
			rgb:
				type: {}
				validate: [
					(val) ->
						valid = true
						for k, v of val
							return false if !_.isNumber(v) or v < 0 or v > 255

						val.r = val.r || 0
						val.g = val.g || 0
						val.b = val.b || 0

						return true
					, 'Invalid RGB Object'
				]
		)]

	sizes:
		# index: true
		type: [new Schema(
			width:
				type: Number
				required: true
			height:
				type: Number
				required: true
		)]

	prices: [ new Schema(
		price:
			type: Number
			required: true
		ref:
			type: {}
			# validate: [(val) ->	TODO: validate price object?
			# 	return true
			# , 'Invalid price object']
	)]

	cats : [{
		type: Schema.Types.ObjectId
		ref: 'Category'
	}]					# categories TODO: format?

	tags : [String]					# tags

	rats : []					# ratings

	cdate :		# create date
		type : 		Date
		default : 	Date.now

	udate : 	# update date
		type : 		Date
		default : 	Date.now
)


# CUSTOM STATIC METHODS
_schema.statics =

	findByColorKey: (colorKey, cb) ->
		query =
			colors:
				$elemMatch:
					key: colorKey

		@find query, cb


	isPresent: ( p ) ->
		c = @

		def = q.defer()
		Model = c.model( schemaName )

		if p instanceof ObjectId

			Model.findOne {_id: p}, (err, prod) ->
				if err
					return def.reject( err )

				if prod is null
					def.reject( p )
				else
					def.resolve( prod )

		return def.promise


_schema.pre 'save', (next) ->
	c = @

	# add product to default categories
	if not _.isArray(c.cats) or c.cats.length is 0
		Category = require('mongoose').model('Category')
		Category.find {type:'default'}, (err, cats) ->
			return errLog.error( err ) if err

			bulk = Category.collection.initializeUnorderedBulkOp()
			_.each cats, (cat) ->
				bulk.find({_id:cat._id}).updateOne( {$addToSet: {items: c._id} } )
				c.cats.push( cat._id)
			bulk.execute (err, rep) ->
				errLog.error( err ) if err
				next()

	# push product to categories
	else
		bulk = Category.collection.initializeUnorderedBulkOp()
		_.each c.cats, (catId) -> bulk.find({_id:catId}).updateOne( {$addToSet: {items: c._id} } )
		bulk.execute (err, rep) ->
			errLog.error( err ) if err
			next()


# CUSTOM INSTANCE METHODS
# _schema.methods =


module.exports = mongoose.model(schemaName, _schema)

