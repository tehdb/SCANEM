# PWD = process.env.PWD
mongoose 	= require('mongoose')
readDir 	= require('readdir')

winston = require('winston')

errLog = winston.loggers.get( 'error' )
infoLog = winston.loggers.get( 'info' )

# fs = require('fs')
# path = require('path')

o =

	init: ->
		c = @
		mongoose.connect( global.CONF().db )
		db = mongoose.connection
		db.on 'error', -> errLog.error( 'db connection error...' )
		db.once 'open', -> infoLog.info( 'db connection opened...' )



		# scan all dirs for models and register them
		# path = "#{__dirname}/../"
		path = "#{global.CONF().root}/server"
		models = readDir.readSync( path, ['**.mdl.coffee'] )


		require("#{path}/#{model}") for model in models

		c.setDefaults()
		return db

	setDefaults: ->

		# errLog.info('error message')
		# errLog.error('some error')

		# console.log "was geht?"

		# infoLog.info('info message')
		mongoose.model('Category').ensureDefaults()

		# console.log mongoose.model('Product')?
		# console.log mongoose.model('Category')?
		# console.log "set defaults "
		# Cat = mongoose.model('Category')
		# Cat.setDefault({
		# 	name: global.CONF().defaults.category.name
		# 	type: 'default'
		# })









module.exports = o.init()

