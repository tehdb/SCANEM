# PWD = process.env.PWD
mongoose 	= require('mongoose')
readDir 	= require('readdir')

# fs = require('fs')
# path = require('path')

module.exports = ->
	mongoose.connect( global.CONF().db )
	db = mongoose.connection
	db.on( 'error', console.error.bind( console, 'connection error...') )
	db.once 'open', -> console.log('db connection opened...')



	# scan all dirs for models and register them
	# path = "#{__dirname}/../"
	path = "#{global.CONF().root}/server"
	models = readDir.readSync( path, ['**.mdl.coffee'] )


	require("#{path}/#{model}") for model in models



	# console.log mongoose.model('Product')?
	# console.log mongoose.model('Category')?

	Cat = mongoose.model('Category')
	Cat.setDefault({
		name: global.CONF().defaults.category.name
		type: 'default'
	})


	return db
