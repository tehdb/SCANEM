PWD = process.env.PWD

router = require('express').Router()
fs = require('fs')
path = require('path')



module.exports = (pubsub) ->

	pathToModules = "#{global.CONF().root}/server"

	# TODO: use readdir!!!
	# init routes
	fs.readdirSync( pathToModules ).forEach ( file ) ->
		modulePath = "#{pathToModules}/#{file}"
		stats = fs.statSync( modulePath )
		if stats.isDirectory()
			routesFilePath = "#{modulePath}/#{file}.rt.coffee"

			# fileStats = fs.statSync( routesFilePath )

			# console.log routesFilePath
			if fs.existsSync( routesFilePath )
				require( routesFilePath )(router, pubsub)
			# console.log fs.existsSync( routesFilePath )

			# console.log routesFilePath
			# # if fs.existsSync( routesFilePath )

			# try
			# 	# console.log routesFilePath
			# 	require( routesFilePath )(router, pubsub)
			# catch e
			# 	# console.log "error?"
				# console.log e

	return router


