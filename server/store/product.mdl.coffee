_ = require('lodash')
mongoose = require('mongoose')
Schema = mongoose.Schema

_schemaName = 'Product'


colorsSchema = new Schema(
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
)

# variantsSchema = new Schema(
# 	width: Number
# 	height: Number
# 	price: Number
# 	imgs: [String]
# 	colors: [colorsSchema]
# )

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
		# index: true
		type: [ colorsSchema ]

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
	# imgs : []					# images
	cats : []					# categories TODO: format?
	tags : []					# tags
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

# CUSTOM STATIC METHODS
_schema.statics =
	findByColorKey: (colorKey, cb) ->
		query =
			colors:
				$elemMatch:
					key: colorKey

		@find query, cb

	# findBySize: (sizes, cb) ->






# CUSTOM INSTANCE METHODS
_schema.methods =
	findByColor: (color, cb) ->
		# this.model(_schemaName).find
		#
		console.log "find by color"
		cb(null, [])

	# create: (postData, callback) ->
	# 	this.model('Post').create postData, (err, post) ->
	# 		return callback( err ) if err
	# 		callback( null, post )

module.exports = mongoose.model(_schemaName, _schema)

