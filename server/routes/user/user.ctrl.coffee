# PWD = process.env.PWD

User = require("#{__dirname}/user.mdl")
hat = require('hat')
mongoose = require('mongoose')
encrypt = require("#{__dirname}/encrypt")

module.exports =
	signup : (req, res, next) ->

		user = new User( req.body )

		user.ips.push( req.ip )
		user.token = hat()
		user.status = 'notverified'
		user.salt = encrypt.createSalt()
		user.password = encrypt.hash(user.salt, user.password)

		user.save (err, user) ->
			return res.status(400).json( err ) if err
			res.json( user.getPublicFields() )


	verify : (req, res, next) ->

		condit = { token: req.body.token }
		update =
			status: "verified"
			$unset:
				token: ""

		# console.log user

		User.findOneAndUpdate condit, update, (err, user) ->
			return res.status(400).json( err ) if err
			res.send( user.getPublicFields() )

	login : (req, res, next) ->
		res.send('login')

	logout : (req, res, next) ->
		res.send('logout')
