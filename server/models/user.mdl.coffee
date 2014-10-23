mongoose 	= require('mongoose')

userSchema = new mongoose.Schema(
	email:
		type: String
		lowercase: true
		required: true
		unique: true
	password:
		type: String
		required: true
	# salt:
	# 	type: String
	# 	required: true
	# token: String
	# status: String

	# createdOn:
	# 	type: Date
	# 	default:
	# ip: String
	# type: String
)

module.exports = mongoose.model('User', userSchema)
