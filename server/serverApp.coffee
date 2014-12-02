_ = require('lodash')
EventEmitter 	= require('events').EventEmitter
pubsub 			= new EventEmitter()

conf = require('./config/config')


global.conf = conf 		# TODO: delete
global.CONF = _.constant( conf )

loggers = require('./config/winston') 		# init logger

# infoLog = winston.loggers.get( 'info' )
# express
app = require( './config/express' )

# mongo
require( './config/mongoose')

# passport
require( './config/passport')

# i18n
i18n = require( './config/i18next')( app )

# mailer
require( './mailer' )( pubsub, i18n )

# api routes
app.use 	'/api', require('./config/routes')( pubsub )

# main view
app.get '*', (req, res) -> res.render 'index', { user: req.user?.getPublicFields?()}


# error handler
app.use 	(err, req, res, next) ->
	status = err.status or 400
	reason = err.reason?.message or err.reason?.toString() or 'unknown error'
	res.status( status ).json( {reason : reason } )


process.on 'uncaughtException', (err) -> console.log 'App_Error: ', err.message

# start server
app.listen app.get('port'), -> loggers.info.log( "Listening on port #{app.get('port')}..." )
