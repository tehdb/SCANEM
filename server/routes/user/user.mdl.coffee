

_ = require('lodash')
mongoose = require('mongoose')
encrypt = require("#{__dirname}/encrypt")
# ObjectID = require('mongodb').ObjectID
# hat = require('hat')
# encrypt = require("#{PWD}/server/utils/encryption")
#
# _publicFields = '_id username email token role'
_publicFields = '_id username email role'
_schemaName = 'User'

_schema = new mongoose.Schema(
	username:
		type: String
		lowercase: true
		required: true
		unique: true

	email:
		type: String
		lowercase: true
		unique: true
		required: 'Email address is required'
		match: [/^[0-9a-zA-Z]+([0-9a-zA-Z]*[-._+])*[0-9a-zA-Z]+@[0-9a-zA-Z]+([-.][0-9a-zA-Z]+)*([0-9a-zA-Z]*[.])[a-zA-Z]{2,6}$/, 'Please fill a valid email address']

	password:
		type: String
		required: true

	salt:
		type: String
		required: true

	token:
		type: String
		unique: true
		sparse: true

	status: String

	# TODO: think about
	# capabilities: []
	role:
		type: String
		required: true
		default: 'user'


	ips: []

	loginOn:
		type: Date
		default: Date.now

	createOn:
		type: Date
		default: Date.now

	updateOn:
		type: Date
		default: Date.now
)



_schema.methods =
	getPublicFields: ->
		return _.pick( this, _publicFields.split(' '))

	authenticate: (data, cb) ->

		# find user by email or username with status is 'verified'
		condit =
			$and: [{
				$or: [{
					username: data.username
				},{
					email: data.username
				}] }, {
				status: 'verified'
			}]

		this.model(_schemaName).findOne condit, (err, user) ->
			return cb( err ) if err
			return cb( new Error('user not found') ) if !user?

			if encrypt.hash( user.salt, data.password ) is user.password
				cb?( null, user.getPublicFields() )
			else
				cb?( new Error('password not match'))





module.exports = mongoose.model(_schemaName, _schema)



