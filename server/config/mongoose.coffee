
mongoose 		= require('mongoose')

module.exports = ->
	mongoose.connect( 'mongodb://localhost/SCANEM')
	db = mongoose.connection
	db.on( 'error', console.error.bind( console, 'connection error...') )
	db.once 'open', -> console.log('db connection opened...')