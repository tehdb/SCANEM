fs = require('fs')

i18nCtrl =
	get: (req, res, next) ->

		# get a list of available languages
		if req.params.langs is 'all'

			langsDir = "#{__dirname}/langs"
			result = []

			fs.readdirSync( langsDir ).forEach ( file ) ->
				langData = fs.readFileSync( "#{langsDir}/#{file}" )
				langData = JSON.parse( langData )

				result.push({
					"lang_key" : langData.lang_key
					"lang_intval" : langData.lang_intval
				})

			res.status(200).json( result )

		# get lables for language
		else if req.query.lang?
			lang = req.query.lang.replace('_', '-')
			langFile = "#{__dirname}/langs/#{lang}.json"

			fs.readFile langFile, 'utf8', (err, data) ->
				return res.status(400).send( err ) if err

				data = JSON.parse(data)

				res.json( data.labels )

		# wrong call
		else
			next()

module.exports = ( router ) ->
	router
		.route('/i18n/:langs?')
		.get( i18nCtrl.get )