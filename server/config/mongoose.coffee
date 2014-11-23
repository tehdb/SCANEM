# PWD = process.env.PWD
mongoose 	= require('mongoose')
readDir 	= require('readdir')

# fs = require('fs')
# path = require('path')

module.exports = (conf)->
	mongoose.connect( conf.db )
	db = mongoose.connection
	db.on( 'error', console.error.bind( console, 'connection error...') )
	db.once 'open', -> console.log('db connection opened...')

	# scan all dirs for models and register them
	# path = "#{__dirname}/../"
	path = "#{conf.root}/server"
	models = readDir.readSync( path, ['**.mdl.coffee'] )

	require("#{path}/#{model}") for model in models

	return db
