
# _ 			= require('lodash')
request 	= require('superagent')
expect 		= require('chai').expect
sinon 		= require('sinon')

db = require('monk')('localhost/mean-cs')

URL = 'http://localhost:3030/api/users'
TestUser = null
TestUserData =
	email: 'test@user.com'
	password: 'testtest'

# UsersData = require('../../data/users.json')


describe 'users api', ->

	before (done) ->
		request
			.post( URL )
			.send( TestUserData )
			.end (err, res) ->
				expect( err ).to.be.null
				TestUser = res.body
				expect( TestUser.email ).to.equal( TestUserData.email )
				done()


	# clean up db
	after (done) ->
		users = db.get('users')
		users.remove TestUser, (err ) ->
			expect( err ).to.be.null
			done()


	#it 'should add a user', (done) ->

	it 'should select a user by id', (done) ->
		request
			.get("#{URL}/id/#{TestUser._id}")
			.end (err, res) ->
				expect( res.body._id ).to.equal( TestUser._id )
				done()

	it 'should select a user by email', (done) ->
		request
			.get("#{URL}/email/#{TestUser.email}")
			.end (err, res) ->
				expect( res.body._id ).to.equal( TestUser._id )
				done()

	it 'should select next few users', (done) ->
		request
			.get("#{URL}")
			.end (err, res) ->
				expect( err ).to.be.null
				expect( res.body ).to.be.an 'array'
				done()

	it 'should update a user', (done) ->
		TestUser.email = 'updated@user.com'
		request
			.put("#{URL}")
			.send( TestUser )
			.end (err, res) ->
				expect( err ).to.be.null
				expect( res.body.email ).to.equal( TestUser.email )
				done()

