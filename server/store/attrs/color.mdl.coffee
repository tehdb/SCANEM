
mongoose = require('mongoose')
Schema = mongoose.Schema
sname = 'Color'
ObjectId = Schema.Types.ObjectId

schema = new Schema(
	key:
		type: 		String
		required: 	true
		unique: 	true
		index: 		true

	rbg: {}
	hex: String
	occur: [{
		type: ObjectId
		ref: 'Product'
	}]
)

module.exports = mongoose.model(sname, schema)