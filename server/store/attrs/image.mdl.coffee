
mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

sname = 'Image'

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

module.exports = mongoose.model(sname, schema)