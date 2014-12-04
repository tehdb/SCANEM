mongoose = require('mongoose')
Schema = mongoose.Schema

schema = new Schema(
	src:
		type: String
		required: true

	alt:
		type: String

	# TODO: meta info
	# width: 	Number
	# height: Number
	# type:
)

module.exports = schema