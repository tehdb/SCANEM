_ = require('lodash')
mongoose = require('mongoose')
Schema = mongoose.Schema

_schemaName = 'Product'

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

	# vars : [variantsSchema]		# variants
	# orie :
	# 	type: String 				# orientation - landscape | portrait | quadratic
	# 	enum: ['landscape', 'portrait', 'quadratic']

	cdate :		# create date
		type : 		Date
		default : 	Date.now

	udate : 	# update date
		type : 		Date
		default : 	Date.now
)

# _schema.post 'save', (doc) ->


# CUSTOM STATIC METHODS
_schema.statics =
	insertToCat: (pArr, cb) ->
		c = @
		Category = require('mongoose').model('Category')

		# get default cat
		# every prod has a cat, if not set defaul
		# save every product
		# push ever prod id to cats
		Category.getDefault (err,defCat) ->
			return cb?(err) if err
			pArr = _.each pArr, (p) -> p.cats = [defCat._id] if not _.isArray(p.cats) or p.cats.length is 0

			c.create pArr, (err, pArr...) -> # p... because create returns a list of params
				return cb?(err) if err


				bulk = Category.collection.initializeUnorderedBulkOp()
				_.each pArr, (p) ->
					_.each p.cats, (catId) ->
						bulk.find({_id:catId}).updateOne( {$push: {items: p._id} } )

				bulk.execute (err, rep) ->
					return cb?(err) if err

					prodIds = _.pluck( pArr, '_id' )
					cb?( null, prodIds )

	findByColorKey: (colorKey, cb) ->
		query =
			colors:
				$elemMatch:
					key: colorKey

		@find query, cb

# 	findByCategoryName: (catName, cb) ->
# 		catMdl =

# 	# findBySize: (sizes, cb) ->

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

		# Category.find {type:'default'}, (err, defCats) ->
		# 	return errLog.error( err ) if err

		# 	bulk = Category.collection.initializeUnorderedBulkOp()
		# 	_.each defCats, (defCat) ->
		# 		c.cats.push( defCat._id )

		# 		defCat.items.push( c._id )
		# 		defCat.save (err) -> errLog.error( err ) if err




	# else

			# c.save (err) -> errLog.error( err ) if err


		# bulk = Category.collection.initializeUnorderedBulkOp()
		# _.each





# # CUSTOM INSTANCE METHODS
# # _schema.methods =
# # 	findByColor: (color, cb) ->
# # 		console.log "find by color"
# # 		cb(null, [])

module.exports = mongoose.model(_schemaName, _schema)

