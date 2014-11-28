# PWD = process.env.PWD

express			= require('express')
bodyParser 		= require('body-parser')
cookieParser 	= require('cookie-parser')
methodOverride 	= require('method-override')
multer 			= require('multer')
logger 			= require('morgan')
errorHandler 	= require('errorhandler')
session			= require('express-session')
passport 		= require('passport')

# module.exports = (conf)->

app = express()

app.use(require('prerender-node').set('prerenderServiceUrl', 'http://localhost:3000') )

app.set 	'port', conf.port
app.set 	'view engine', 'jade'
app.set 	'views', "./server/views"
app.use 	methodOverride()
app.use 	bodyParser.json()
app.use 	bodyParser.urlencoded({ extended: true })
app.use		session({ secret: 'SCANEM', saveUninitialized:true, resave: true })
app.use 	cookieParser()
app.use 	express.static( "#{conf.root}/public" )
app.use 	express.static( "#{conf.root}/bower_components" )

app.use 	passport.initialize()
app.use 	passport.session()

# app.use 	logger('dev')
app.use 	errorHandler()


module.exports = app

