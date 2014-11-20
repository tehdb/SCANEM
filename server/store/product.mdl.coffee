_ = require('lodash')
mongoose = require('mongoose')
Schema = mongoose.Schema

_schemaName = 'Product'


colorsSchema = new Schema(
	key: String
	val:
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

variantsSchema = new Schema(
	width: Number
	height: Number
	price: Number
	imgs: [String]
	colors: [colorsSchema]
)

_schema = new Schema(

	title :
		type : 		String
		required : 	true

	ean :
		type : 		String
		required : 	true
		unique : 	true

	imgs : []					# images
	cats : []					# categories TODO: format?
	tags : []					# tags
	rats : []					# ratings
	vars : [variantsSchema]		# variants
	orie :
		type: String 				# orientation - landscape | portrait | quadratic
		enum: ['landscape', 'portrait', 'quadratic']
	cdate :		# create date
		type : 		Date
		default : 	Date.now

	udate : 	# update date
		type : 		Date
		default : 	Date.now
)

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


###
vars = [
	{
		width: Number
		height: Number
		price: Number
		imgs: []
		colors: [
			{
				key: 'blue'
				val:
					r:	0
					g:	0
					b: 255
			}
		]
	}
]
###
