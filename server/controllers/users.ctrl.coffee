_ = require('lodash')
fs = require('fs')


_cachedData = fs.readFileSync('./server/database/users.json', {encoding:'utf-8'})
_cachedData = JSON.parse(_cachedData)
_entryProperties = _.keys(_cachedData[0])


module.exports =
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
			max = if max? then max else 10

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

			out = out.slice(0, max) if max != -1

			#console.log max

			res.json( out )


		selectSingle: (req, res, next) ->
			email = req.params.email

			entry = _.find _cachedData, (e) ->
				return e.email is email

			res.json( entry )





