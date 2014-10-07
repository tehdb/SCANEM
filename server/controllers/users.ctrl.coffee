fs = require('fs')

module.exports =
		# select all users from db
		select: (req, res, next) ->
			fs.readFile './server/database/users.json', (err, data) ->
				return res.status(400).json( {"reason" : err.toString()} ) if err
				json = JSON.parse(data)
				res.json( json )

		# append neu user to db
		insert: (req, res, next) ->
			data = req.body

			console.log data

			res.json( {status: 'OK'} )





