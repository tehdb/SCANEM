prerender = require('prerender')

server = prerender
	workers: 2 				# number of phantomjs processes to start
	iterations: 200  		#	/number of requests to server before restarting phantomjs
	phantomArguments: [		# arguments passed into each phantomjs process
		"--load-images=false"
		"--ignore-ssl-errors=true"
	]

server.use(prerender.blacklist())
server.use(prerender.removeScriptTags())
server.use(prerender.httpHeaders())
# server.use(prerender.s3HtmlCache())
# server.use(require('my-plugin'))

server.start()
