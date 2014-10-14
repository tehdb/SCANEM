userCtrl = require('./controllers/users.ctrl')

module.exports = ( app ) ->

	# app.get '/api/users', (req, res) ->
	# 	res.json({status: 'ok'})
	#
	#

	#  api/users/sort=XXX&q=XXX&max=XXX
	#
	#app.get '/api/users/:page?', userCtrl.select
	app.get '/api/users', userCtrl.selectMulti
	app.get '/api/user/:email', userCtrl.selectSingle

	#app.post '/api/users', userCtrl.insert

		# {
		# 	search: ''
		# 	filter: ''

		# 	max: ''
		# }


	# unknow route
	# app.get '*', (req, res) ->
	# 	res.send('<h1 style="color:red;">route not found</h1>')
	#
	app.get '*', (req, res) ->
		res.render 'index'
