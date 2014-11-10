_ = require('lodash')
mongoose = require('mongoose')
Schema = mongoose.Schema

_schemaName = 'Product'

rgbSchema = new Schema(
	r:
		type: Number
		required: true
		default: 0
	g:
		type: Number
		required: true
		default: 0
	b:
		type: Number
		required: true
		default: 0
)

colorsSchema = new Schema(
	key: String
	val: {} #rgbSchema
)

variantsSchema = new Schema(
	width: Number
	height: Number
	price: Number
	imgs: [String]
	colors: [colorsSchema]
	# colors: []
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
	cats : []					# categories
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
