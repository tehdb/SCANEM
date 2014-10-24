express			= require('express')
bodyParser 		= require('body-parser')
cookieParser 	= require('cookie-parser')
methodOverride 	= require('method-override')
multer 			= require('multer')
logger 			= require('morgan')
errorHandler 	= require('errorhandler')
session			= require('express-session')

passport 		= require('passport')

app = express()

app.use(require('prerender-node').set('prerenderServiceUrl', 'http://localhost:3000') )

app.set 	'port', 3030
app.set 	'view engine', 'jade'
app.set 	'views', "./server/views"
app.use 	methodOverride()
app.use 	bodyParser.json()
app.use 	bodyParser.urlencoded({ extended: true })
app.use		session({ secret: 'SCANEM', saveUninitialized:true, resave: true })
app.use 	cookieParser()
app.use 	express.static( "./public" )
app.use 	express.static( "./bower_components" )

app.use 	passport.initialize()
app.use 	passport.session()

app.use 	logger('dev')
app.use 	errorHandler()

# mongo
require( './config/mongoose')()

# passport
require( './config/passport')()

# routes
app.use 	'/api', require('./routes')
app.get 	'*', 	(req, res) -> res.render 'index'



app.listen app.get('port'), ->
	console.log "Listening on port #{app.get('port')}..."
