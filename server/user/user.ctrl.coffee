# PWD = process.env.PWD

hat = require('hat')
mongoose = require('mongoose')

User = require("#{__dirname}/user.mdl")
encrypt = require("#{__dirname}/encrypt")


module.exports = (pubsub) ->
	return out =
		signup : (req, res, next) ->

			user = new User( req.body )

			user.ips.push( req.ip )
			user.token = hat()
			user.status = 'notverified'
			user.salt = encrypt.createSalt()
			user.password = encrypt.hash(user.salt, user.password)

			user.save (err, user) ->
				return res.status(400).json({ 'reason' : err }) if err

				publicUserData = user.getPublicFields()

				pubsub.emit('UserCreatedEvent', publicUserData)

				res.json( publicUserData )


		verify : (req, res, next) ->

			condit = { token: req.body.token }
			update =
				status: "verified"
				$unset:
					token: ""

			User.findOneAndUpdate condit, update, (err, user) ->
				return res.status(400).json({ 'reason' : err }) if err

				return res.status(400).json({ 'reason' : 'User not found'}) if !user?


				pubsub.emit('UserVerifiedEvent', user)

				res.send( user.getPublicFields() )

		login : (req, res, next) ->
			res.send('login')

		logout : (req, res, next) ->
			res.send('logout')
