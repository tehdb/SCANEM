PWD = process.env.PWD

router = require('express').Router()
fs = require('fs')
path = require('path')



module.exports = (pubsub) ->

	pathToModules = "#{PWD}/server"
	# init routes
	fs.readdirSync( pathToModules ).forEach ( file ) ->
		modulePath = "#{pathToModules}/#{file}"
		stats = fs.statSync( modulePath )
		if stats.isDirectory()
			routesFilePath = "#{modulePath}/#{file}.rt"

			# console.log routesFilePath
			# console.log fs.existsSync( routesFilePath )

			# if fs.existsSync( routesFilePath )
				# console.log routesFilePath
			try
				require( routesFilePath )(router, pubsub)
			catch e
				# console.log e

	return router


