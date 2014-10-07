





userCtrl = require('./controllers/users.ctrl')

module.exports = ( app ) ->



	# app.get '/api/users', (req, res) ->
	# 	res.json({status: 'ok'})
	#
	app.get '/api/users', userCtrl.select
	app.post '/api/users', userCtrl.insert

	# unknow route
	app.get '*', (req, res) ->
		res.send('<h1 style="color:red;">route not found</h1>')
