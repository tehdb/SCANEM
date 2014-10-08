_ = require('lodash')
fs = require('fs')

_cachedData = fs.readFileSync('./server/database/users.json', {encoding:'utf-8'})
_cachedData = JSON.parse(_cachedData)
_entryProperties = _.keys(_cachedData[0])


_loadData = (cb) ->
	fs.readFile './server/database/users.json', (err, data) ->
		return cb( err ) if err
		json = JSON.parse(data)

		cb( null, json )

# 1 		2 			3 			4
# 0-9		10-19 		20-29 		30-39
_entriesPerPage = 10
_sendDataPaged = (res, page) ->
	start = (page-1)*_entriesPerPage
	end = start + _entriesPerPage

	pagedData = _cachedData.slice( start, end )

	res.json( pagedData )


module.exports =
		# select all users from db
		# select: (req, res, next) ->
		# 	page = parseInt( req.params.page, 10 ) || 1

		# 	if not _cachedData
		# 		_loadData (err, data) ->
		# 			return res.status(400).json( {"reason" : err.toString()} ) if err
		# 			_cachedData = data
		# 			_sendData( res, page )
		# 	else
		# 		_sendData( res, page )
		#

		# p - search by proporty
		# q - search string
		# m - max result entries
		# s - sort by property
		selectMulti: (req, res, next) ->
			out = null

			prop = req.query.p
			query = if req.query.q then req.query.q.toLowerCase() else null
			sort = req.query.s || null
			max = parseInt( req.query.m, 10 ) # || 10
			max = if max > 0 then max else 10

			# filter if query passed
			if query
				# by property
				if prop and _.contains( _entryProperties, prop )
					out = _.filter _cachedData, (e) ->
						return _.contains( e[prop].toLowerCase(), query )

				# thru all properties
				else
					out = _.filter _cachedData, (e) ->
						return _.some e, (p) -> return _.contains( p.toLowerCase(), query )
			else
				out = _cachedData

			out = _.sortBy(out, sort) if sort
			out = out.slice(0, max)
			res.json( out )


		selectSingle: (req, res, next) ->
			email = req.params.email

			entry = _.find _cachedData, (e) ->
				return e.email is email

			res.json( entry )





