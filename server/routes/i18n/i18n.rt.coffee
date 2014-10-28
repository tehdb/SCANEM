PWD = process.env.PWD
fs = require('fs')

_langsDir = "#{PWD}/server/i18n/client"

i18nCtrl =
	get: (req, res, next) ->

		# get a list of available languages
		if req.params.langs is 'all'

			result = []

			fs.readdirSync( _langsDir ).forEach ( file ) ->
				langData = fs.readFileSync( "#{_langsDir}/#{file}" )
				langData = JSON.parse( langData )

				result.push({
					"lang_key" : langData.lang_key
					"lang_intval" : langData.lang_intval
				})

			res.status(200).json( result )

		# get lables for language
		else if req.query.lang?
			lang = req.query.lang.replace('_', '-')
			langFile = "#{_langsDir}/#{lang}.json"

			fs.readFile langFile, 'utf8', (err, data) ->
				return res.status(400).send( { 'reason' : err } ) if err

				data = JSON.parse(data)

				res.json( data.labels )

		# wrong call
		else
			next()

module.exports = ( router ) ->
	router
		.route('/i18n/:langs?')
		.get( i18nCtrl.get )