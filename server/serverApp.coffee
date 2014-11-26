_ = require('lodash')
EventEmitter 	= require('events').EventEmitter
pubsub 			= new EventEmitter()

conf = require('./config/config')

global.conf = conf
global.CONF = _.constant( conf )
# express
app = require( './config/express' )(conf)

# mongo
require( './config/mongoose')(conf)

# passport
require( './config/passport')()

# i18n
i18n = require( './config/i18next')( app )

# mailer
require( './mailer' )( pubsub, i18n )

# api routes
app.use 	'/api', require('./config/routes')( pubsub )

# main view
app.get 	'*', (req, res) ->
	res.render 'index', { user: req.user?.getPublicFields?()}


# error handler
app.use 	(err, req, res, next) ->
	status = err.status or 400
	reason = err.reason?.message or err.reason?.toString() or 'unknown error'
	res.status( status ).json( {reason : reason } )


# start server
app.listen app.get('port'), ->
	console.log "Listening on port #{app.get('port')}..."
