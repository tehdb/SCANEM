PWD = process.env.PWD
# router = require('express').Router()



module.exports = (router, eventEmmiter) ->
	ctrl = require("#{__dirname}/user.ctrl")(eventEmmiter)
	auth = require("#{global.CONF().root}/server/config/auth")

	router
		.route('/user/signup')
		.post( ctrl.signup )

	router
		.route('/user/verify')
		.post( ctrl.verify )

	# router
	# 	.route('/user/reset')
	# 	.post( ctrl.restore )

	router
		.route('/user/login')
		.post( auth.login )


	router
		.route('/user/logout')
		.post( auth.logout )


# singUp
# resetPassword
# logIn
# logOut
# verify
