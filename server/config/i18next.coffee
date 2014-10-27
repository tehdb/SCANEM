PWD = process.env.PWD
i18n 		= require('i18n')

module.exports = (app) ->
	# app.use 	i18n.handle

	# i18n.init
	# 	lng: 			'en',
	# 	# ignoreRoutes: 	['public/']
	# 	resGetPath: 	"#{PWD}/server/i18n/mailer/__lng__.json"
	# 	debug: 			true
	# 	# useCookie: 		true
	# 	# cookieName: 	'lang'
	# 	detectLngFromHeaders: 	false

	# return i18n
	#

	i18n.configure({
		locales: ['en-GB', 'de-DE']
		directory: "#{PWD}/server/i18n/mailer/"
		defaultLocale: 'en-GB'
		updateFiles: false
		objectNotation: true
		cookie: 'lang'

	})


	return i18n



