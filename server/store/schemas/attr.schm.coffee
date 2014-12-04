mongoose = require('mongoose')
Schema = mongoose.Schema

schema = new Schema(
	key:
		type: String
		required: true
	val:
		type: {}
		required: true
		# validate:
)

module.exports = schema