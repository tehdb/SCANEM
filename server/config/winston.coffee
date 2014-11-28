fs = require('fs')
winston = require('winston')


if !fs.existsSync( global.CONF().logPath )
	fs.mkdirSync global.CONF().logPath, '0766', (err) ->
		return console.error("Can't create dir: #{ global.CONF().logPath}") if err
	# console.log err

winston.remove(winston.transports.Console)

module.exports =
	error: winston.loggers.add 'error', {
		console:
			silent: true
		file:
			filename: 'logs/error'
			maxsize: 2097152
			maxFiles: 5
			silent: false
			colorize: true
	}

	info: winston.loggers.add 'info', {
		console:
			silent: true
		file:
			filename: 'logs/info'
			maxsize: 2097152
			maxFiles: 5
			silent: false
			colorize: true
	}


# winston.loggers.get('error').info('------- app start -------')
# winston.loggers.get('info').info('------- app start -------')

# module.exports = {
# 	error: winston.loggers.get('error')
# 	info: winston.loggers.get('info')
# }




# process.on 'exit', (code) ->
# 	# console.log "on exit #{code}"
# 	winston.loggers.get('error').info('*** app stop ***')
# 	winston.loggers.get('info').info('*** app stop ***')

# # catch ctrl+c event and exit normally
# process.on 'SIGINT', ->
# 	process.exit(2)
