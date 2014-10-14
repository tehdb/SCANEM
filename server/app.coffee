express			= require('express')
bodyParser 		= require('body-parser')
methodOverride 	= require('method-override')
multer 			= require('multer')
logger 			= require('morgan')
errorHandler 	= require('errorhandler')
mongoose 		= require('mongoose')

app = express()

app.use(require('prerender-node').set('prerenderServiceUrl', 'http://localhost:3000') )

app.set 	'port', 3030
app.set 	'view engine', 'jade'
app.set 	'views', "./server/views"
app.use 	methodOverride()
app.use 	bodyParser.json()
app.use 	bodyParser.urlencoded()

app.use 	express.static( "./public" )
app.use 	express.static( "./bower_components" )

app.use 	logger('dev')
app.use 	errorHandler()

# mongo
mongoose.connect( 'mongodb://localhost/mean-cs')
db = mongoose.connection
db.on( 'error', console.error.bind( console, 'connection error...') )
db.once 'open', -> console.log('db connection opened...')


# routes
app.use 	'/api', require('./routes')
app.get 	'*', 	(req, res) -> res.render 'index'


#require( './routes')(app)

app.listen app.get('port'), ->
	console.log "Listening on port #{app.get('port')}..."
