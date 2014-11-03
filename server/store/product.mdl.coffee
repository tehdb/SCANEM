_ = require('lodash')
mongoose = require('mongoose')

_schemaName = 'Product'
_schema = new mongoose.Schema(

	title :
		type : 		String
		required : 	true

	ean :
		type : 		String
		required : 	true
		unique : 	true

	imgs : []	# images
	cats : []	# categories
	tags : []	# tags
	rats : []	# ratings
	vars : []	# variants

	cdate :		# create date
		type : 		Date
		default : 	Date.now

	udate : 	# update date
		type : 		Date
		default : 	Date.now
)

module.exports = mongoose.model(_schemaName, _schema)