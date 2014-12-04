#PWD 	= process.env.PWD
#_ 		= require('lodash')
#expect 	= require('chai').expect
# q = require('q')

path = require('path');
root = path.normalize("#{__dirname}/../../..")

# console.log root

global.CONF = ->
	conf = require("#{root}/server/config/config")
	conf.dataGenerator = require('./dataGenerator')
	return conf


describe 'setup server', ->
	it 'should setup and start server', (done) ->
		app = require "#{root}/server/serverApp"
		done()






