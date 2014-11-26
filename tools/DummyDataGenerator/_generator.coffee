PWD 	= process.env.PWD
_ = require('lodash')


EventEmitter 	= require('events').EventEmitter
pubsub 			= new EventEmitter()
stdio = require('stdio')


conf = require("#{PWD}/server/config/config")
conf.cats =[
	{ name: 'Testcat' },
	{ name: 'Philander' },
	{ name: 'Antipater' },
	{ name: 'Itxaro' },
	{ name: 'Victorina' },
	{ name: 'Winoc' },
	{ name: 'Prometheus' },
	{ name: 'Branislava' }
]



ops = stdio.getopt({
	'supply' : { key: 's', description: 'fill the db with test data'}
	'clear' : { key: 'c', description: 'remove test data from db'}
})


if ops.supply
	conf.pCount = 1000
	Supplier = require('./Supplier')
	s = new Supplier(conf)
	s.supply()

else if ops.clear
	Cleaner = require('./Cleaner')
	c = new Cleaner(conf)
	c.clean()
