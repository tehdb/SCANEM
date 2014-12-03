PWD 	= process.env.PWD
# _ 		= require('lodash')
# expect 	= require('chai').expect
# q = require('q')

global.CONF = ->
	conf = require("#{PWD}/server/config/config")
	conf.dataGenerator = require('./dataGenerator')
	return conf


describe 'setup server', ->
	it 'should setup and start server', (done) ->
		app = require "#{PWD}/server/serverApp"
		done()






