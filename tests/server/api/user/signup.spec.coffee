
# _ 			= require('lodash')
request 	= require('superagent')
expect 		= require('chai').expect
sinon 		= require('sinon')


db = require('monk')('localhost/SCANEM')

URL = 'http://localhost:3030/api/user'
TestUser = null
TestUserData =
	email: 'test@user.com'
	username: 'testuser'
	password: '123123123123'


describe 'api user sing up', ->

		# clean up db
	after (done) ->
		users = db.get('users')
		users.remove {_id: TestUser._id}, (err ) ->
			expect( err ).to.be.null
			done()

	it 'should signup', (done) ->
		request
			.post( "#{URL}/signup" )
			.send( TestUserData )
			.end (err, res) ->
				# expect( res.body._id ).to.equal( TestUser._id )
				# console.log res.body
				TestUser = res.body
				expect( res.status ).to.equal( 200 )
				expect( TestUser.email ).to.equal( TestUserData.email )
				expect( TestUser.username ).to.equal( TestUserData.username )
				done()

	it 'should not signup if username is missing', (done) ->
		tempData =
			email: 'test@user.com'
			password: '123123123123'

		request
			.post( "#{URL}/signup" )
			.send( tempData )
			.end (err, res) ->
				expect( res.status ).to.equal( 400 )
				expect( res.body.name ).to.equal( 'ValidationError' )
				done()

	it 'should not signup if username is empty', (done) ->
		tempData =
			username: ''
			email: 'test@user.com'
			password: '123123123123'

		request
			.post( "#{URL}/signup" )
			.send( tempData )
			.end (err, res) ->
				expect( res.status ).to.equal( 400 )
				expect( res.body.name ).to.equal( 'ValidationError' )
				done()


	it 'should not signup if email is missing', (done) ->
		tempData =
			username: 'testuser'
			password: '123123123123'

		request
			.post( "#{URL}/signup" )
			.send( tempData )
			.end (err, res) ->
				expect( res.status ).to.equal( 400 )
				expect( res.body.name ).to.equal( 'ValidationError' )
				done()

	it 'should not signup if email is empty', (done) ->
		tempData =
			username: 'testuser'
			password: '123123123123'

		request
			.post( "#{URL}/signup" )
			.send( tempData )
			.end (err, res) ->
				expect( res.status ).to.equal( 400 )
				expect( res.body.name ).to.equal( 'ValidationError' )
				done()

	it 'should not signup if email is invalid', (done) ->
		tempData =
			email: 'test'
			username: 'testuser'
			password: '123123123123'

		request
			.post( "#{URL}/signup" )
			.send( tempData )
			.end (err, res) ->
				expect( res.status ).to.equal( 400 )
				expect( res.body.name ).to.equal( 'ValidationError' )
				done()

