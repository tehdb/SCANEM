passport = require('passport')


exports.login = ( req, res, next ) ->

	auth = passport.authenticate 'local', ( err, user ) ->

		return next( { status: 400, reason: err } ) if err

		req.logIn user, ( err ) ->
			return next( err ) if err

			res.json( user )

	auth( req, res, next )


exports.requiresApiLogin = (req, res, next) ->
	if !req.isAuthenticated()
		res.status( 403 ).end()
	else
		next()


exports.requiresRole = (role) ->
	return ( req, res, next ) ->
		if !req.isAuthenticated() or req.user.roles.indexOf(role) is -1
			res.status(403).end()
		else
			next()


exports.logout = (req, res) ->
	req.logout()
	res.json( {status: 'success'} )
