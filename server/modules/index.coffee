

router = require('express').Router()
fs = require('fs')
path = require('path')


module.exports = (pubsub) ->
	# init routes
	fs.readdirSync( __dirname ).forEach ( file ) ->
		modulePath = "#{__dirname}/#{file}"
		stats = fs.statSync( modulePath )
		if stats.isDirectory()
			require( "#{modulePath}/#{file}.rt" )(router, pubsub)

	return router


