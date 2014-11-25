_ = require('lodash')
mongoose = require('mongoose')
Schema = mongoose.Schema

schemaName = 'Category'

schema = new Schema(
	name:
		type: 		String
		require: 	true
		unique: 	true
		index: 		true

	descriptions: String
	# items: [Schema.Types.ObjectId]
)

# CUSTOM STATIC METHODS
# schema.statics =

# CUSTOM INSTANCE METHODS
# schema.methods =

module.exports = mongoose.model(schemaName, schema)