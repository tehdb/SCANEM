PWD = process.env.PWD
# router = require('express').Router()

ctrl = require("#{__dirname}/user.ctrl")
auth = require("#{PWD}/server/config/auth")


module.exports = (router) ->

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
