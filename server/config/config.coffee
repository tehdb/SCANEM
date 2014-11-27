path = require('path');
root = path.normalize("#{__dirname}/../../")

env = process.env.NODE_ENV || 'development'

config =
	development :
		root: 	root
		port: 	process.env.PORT || 3030
		db: 	'mongodb://localhost/SCANEM_dev'
		logPath: "#{root}/logs"
		prot: 	'http'
		url: 	'localhost'
		defaults:
			category:
				name: 'default'
				type: 'default'


config.development.apiUrl =
	"
		#{config.development.prot}://\
		#{config.development.url}:\
		#{config.development.port}/api
	"

module.exports = config[env]


	# testing :
	# 	rootPath : 	rootPath
	# 	port : 		process.env.PORT || 3030
	# 	# db : 		'mongodb://flavity_dev:tidy24_fly@81.169.182.96:27017/flavity'
	# 	db : 		'mongodb://localhost/SCANEM_test'
