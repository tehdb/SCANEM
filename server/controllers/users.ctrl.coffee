_ = require('lodash')
fs = require('fs')



_cachedData = null
_entriesPerPage = 10

_loadData = (cb) ->
	fs.readFile './server/database/users.json', (err, data) ->
		return cb( err ) if err
		json = JSON.parse(data)

		cb( null, json )

# 1 		2 			3 			4
# 0-9		10-19 		20-29 		30-39
_sendData = (res, page) ->
	start = (page-1)*_entriesPerPage
	end = start + _entriesPerPage

	pagedData = _cachedData.slice( start, end )

	res.json( pagedData )


module.exports =
		# select all users from db
		select: (req, res, next) ->

			page = parseInt( req.params.page, 10 ) || 1
			# console.log page

			if not _cachedData
				_loadData (err, data) ->
					return res.status(400).json( {"reason" : err.toString()} ) if err
					_cachedData = data
					_sendData( res, page )
			else
				_sendData( res, page )

			# fs.readFile './server/database/users.json', (err, data) ->
			# 	return res.status(400).json( {"reason" : err.toString()} ) if err
			# 	json = JSON.parse(data)
			# 	res.json( json )


		# # append neu user to db
		# insert: (req, res, next) ->
		# 	data = req.body

		# 	console.log data

		# 	res.json( {status: 'OK'} )





