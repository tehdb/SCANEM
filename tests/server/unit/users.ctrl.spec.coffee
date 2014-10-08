pwd 	= process.env.PWD
chai 	= require 'chai'
expect 	= chai.expect
sinon 	= require('sinon')

userCtrl = require("#{pwd}/server/controllers/users.ctrl")

describe 'users controller', ->

	it 'should select multiple entries', ->
		req = {
			query: {}
		}

		res = {
			json : sinon.spy()
		}

		userCtrl.selectMulti( req, res )

		expect( res.json.calledOnce ).to.be.true
		#expect( userCtrl.selectMulti).to.be.a('function')



