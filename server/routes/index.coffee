

router = require('express').Router()
fs = require('fs')
path = require('path')


# init routes
fs.readdirSync( __dirname ).forEach ( file ) ->
	modulePath = "#{__dirname}/#{file}"
	stats = fs.statSync( modulePath )
	if stats.isDirectory()
		require( "#{modulePath}/#{file}.rt" )(router)

module.exports = router


