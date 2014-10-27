EventEmitter 	= require('events').EventEmitter
pubsub 			= new EventEmitter()

# express
app = require( './config/express')


# mongo
require( './config/mongoose')()


# passport
require( './config/passport')()


# i18n
i18n = require( './config/i18next')( app )


# mailer
require( './mailer' )( pubsub, i18n )


# routes
app.use 	'/api', require('./routes')( pubsub )
app.get 	'*', 	(req, res) -> res.render 'index'



app.listen app.get('port'), ->
	console.log "Listening on port #{app.get('port')}..."
