pwd 	= process.env.PWD
_ 		= require 'lodash'
chai 	= require 'chai'
expect 	= chai.expect
sinon 	= require('sinon')

userCtrl = require("#{pwd}/server/controllers/users.ctrl")


describe 'users controller', ->

	it 'should select multiple users', ->
		req = { query: {} }
		res = { json : sinon.spy() }

		userCtrl.selectMulti( req, res )

		expect( res.json.calledOnce ).to.be.true
		expect( res.json.args[0][0] ).to.be.an 'array'


	it 'should limit the results', ->
		req =
			query:
				m: 3

		res = { json : sinon.spy() }

		userCtrl.selectMulti( req, res )
		users = res.json.args[0][0]

		expect( res.json.calledOnce ).to.be.true
		expect( users.length ).to.equal req.query.m


	it 'should filter the results by property', ->
		req =
			query:
				p: 'name'
				q: 'Kyle'

		res = { json : sinon.spy() }

		userCtrl.selectMulti( req, res )
		users = res.json.args[0][0]

		expect( res.json.calledOnce ).to.be.true
		expect( _.every(users, { 'name': 'Kyle' }) ).to.be.true


	it 'should select user by email', ->
		req =
			params:
				email: 'seth@moss.bw'

		res = { json : sinon.spy() }

		userCtrl.selectSingle( req, res)
		user = res.json.args[0][0]

		expect( res.json.calledOnce ).to.be.true
		expect( user ).to.be.an 'object'

		expect( user.name ).to.equal 'Regina'
		expect( user.surname ).to.equal 'Hanson'
		expect( user.email ).to.equal req.params.email




