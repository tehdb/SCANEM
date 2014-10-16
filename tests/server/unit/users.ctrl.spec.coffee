pwd 		= process.env.PWD

_ 			= require 'lodash'
chai 		= require 'chai'
expect 		= chai.expect
sinon 		= require('sinon')
proxyquire 	= require('proxyquire').noCallThru()



userMdlStub = null
userCtrl = null
	# find : sinon.spy()
	# findOne : sinon.spy()




describe 'users controller', ->

	beforeEach ->
		userMdlStub =
			find : sinon.spy()
			findOne : sinon.spy()

		userCtrl = proxyquire("#{pwd}/server/controllers/users.ctrl", {
			'../models/user.mdl': userMdlStub
		})


	it 'should provide select method with no request parameters', ->
		req = { params: {} }
		res = { json : sinon.spy() }

		userCtrl.select( req, res )
		expect( userMdlStub.find.calledOnce ).to.be.true


	it 'should provide select method for query by id', ->
		req = { params: { type: 'id', query: '123' } }
		res = { json : sinon.spy() }

		userCtrl.select( req, res )
		expect( userMdlStub.findOne.calledOnce ).to.be.true


	it 'should provide select method for query by email', ->
		req = { params: { type: 'email', query: 'test@mail.com' } }
		res = { json : sinon.spy() }

		userCtrl.select( req, res )
		expect( userMdlStub.findOne.calledOnce ).to.be.true





