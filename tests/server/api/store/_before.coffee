PWD 	= process.env.PWD
_ 		= require('lodash')
expect 	= require('chai').expect

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
