
# router = require('express').Router()

ctrl = require('./user.ctrl')


module.exports = (router) ->
	router
		.route('/user')
		.get( ctrl.get )
