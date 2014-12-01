PWD 	= process.env.PWD
_ 		= require('lodash')
expect 	= require('chai').expect

q = require('q')

global.CONF = ->
	# can be extended
	conf = require("#{PWD}/server/config/config")
	conf.dataGenerator = require('./_dataGenerator')
	return conf



describe 'setup server', ->
	it 'should setup and start server', (done) ->
		app = require "#{PWD}/server/serverApp"

		# expect(true).to.be.true
		done()

	# it 'should test promises', (done) ->

	# 	fn = ->
	# 		def = q.defer()
	# 		delay = _.random(10, 100)
	# 		setTimeout( ->
	# 			# console.log "timeout"
	# 			def.resolve( "timeout in #{delay}")
	# 		, delay )
	# 		return def.promise

	# 	# fn().then (msg) ->
	# 	# 	console.log msg
	# 	# 	done()

	# 	fns = ->
	# 		promises = []
	# 		promises.push( fn() ) for i in [0..10]
	# 		return promises


	# 	q.all(fns()).spread (res...) ->
	# 		console.log res
	# 		done()






