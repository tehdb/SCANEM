mongoose = require('mongoose')
Schema = mongoose.Schema

schema = new Schema(
	key:
		type: String
		required: true
	rgb:
		type: {}
		validate: [ require('../validators').color, 'Invalid RGB Object']
		# validate: [
		# 	(val) ->
		# 		valid = true
		# 		for k, v of val
		# 			return false if !_.isNumber(v) or v < 0 or v > 255

		# 		val.r = val.r || 0
		# 		val.g = val.g || 0
		# 		val.b = val.b || 0

		# 		return true
		# 	, 'Invalid RGB Object'
		# ]
)

module.exports = schema