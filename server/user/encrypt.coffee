crypto = require('crypto')

exports.createSalt = ->
	return crypto.randomBytes(128).toString('base64')

exports.hash = (salt, pwd) ->
	hmac = crypto.createHmac('sha1', salt)
	return hmac.update(pwd).digest('hex')