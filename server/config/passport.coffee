

PWD = process.env.PWD

passport = require('passport')
LocalStrategy = require('passport-local').Strategy
UserModel = require("#{PWD}/server/routes/user/user.mdl")


module.exports = ->
	passport.use new LocalStrategy {
		usernameField: 'username'
		passwordField: 'password'
	}, (username, password, done) ->
		loginData =
			username: username
			password: password

		new UserModel().authenticate loginData, (err, user) ->
			return done( null, false) if err
			done(null, user )

	passport.serializeUser ( user, done ) ->
		done( null, user._id )

	passport.deserializeUser ( id, done ) ->
		UserModel.findOne {_id: id}, (err, user) ->
			done(err, user)
