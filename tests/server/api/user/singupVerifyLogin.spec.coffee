_ 		= require('lodash')
expect 		= require('chai').expect

mongoose = require('mongoose')

superagent = require('superagent')
agent = superagent.agent()


describe 'api user', ->

	USERS_URL = "#{global.CONF().apiUrl}/user"
	models = {}

	before (done) ->
		models.user = mongoose.model('User')
		done()


	it 'should signup', (done) ->
		userRaw = global.CONF().dataGenerator.getUsers(1)[0]

		agent
			.post( "#{USERS_URL}/signup" )
			.send( userRaw )
			.end (err, res) ->
				expect( res.status ).to.equal( 200 )
				# expect( res.body._id ).to.equal( TestUser._id )
				# console.log res.body
				userRes = res.body
				expect( userRes.email ).to.equal( userRaw.email )
				expect( userRes.username ).to.equal( userRaw.username )
				done()


	it 'should not signup if username is missing', (done) ->
		userRaw = global.CONF().dataGenerator.getUsers(1)[0]
		delete userRaw.username

		agent
			.post( "#{USERS_URL}/signup" )
			.send( userRaw )
			.end (err, res) ->
				expect( res.status ).to.equal( 400 )
				expect( res.body.reason.name ).to.equal( 'ValidationError' )
				done()


	it 'should not signup if username is empty', (done) ->
		userRaw = global.CONF().dataGenerator.getUsers(1)[0]
		userRaw.username = ''

		agent
			.post( "#{USERS_URL}/signup" )
			.send( userRaw )
			.end (err, res) ->
				expect( res.status ).to.equal( 400 )
				expect( res.body.reason.name ).to.equal( 'ValidationError' )
				done()


	it 'should not signup if email is missing', (done) ->
		userRaw = global.CONF().dataGenerator.getUsers(1)[0]

		delete userRaw.email

		agent
			.post( "#{USERS_URL}/signup" )
			.send( userRaw )
			.end (err, res) ->
				expect( res.status ).to.equal( 400 )
				expect( res.body.reason.name ).to.equal( 'ValidationError' )
				done()


	it 'should not signup if email is empty', (done) ->
		userRaw = global.CONF().dataGenerator.getUsers(1)[0]
		userRaw.email = ''

		agent
			.post( "#{USERS_URL}/signup" )
			.send( userRaw )
			.end (err, res) ->
				expect( res.status ).to.equal( 400 )
				expect( res.body.reason.name ).to.equal( 'ValidationError' )
				done()


	it 'should not signup if email is invalid', (done) ->
		userRaw = global.CONF().dataGenerator.getUsers(1)[0]
		userRaw.email = 'invalidemail'

		agent
			.post( "#{USERS_URL}/signup" )
			.send( userRaw )
			.end (err, res) ->
				expect( res.status ).to.equal( 400 )
				expect( res.body.reason.name ).to.equal( 'ValidationError' )
				done()


	it 'should not log in if user is not verified', (done) ->
		userRaw = global.CONF().dataGenerator.getUsers(1)[0]
		agent
			.post( "#{USERS_URL}/login" )
			.send( _.pick(userRaw, 'username', 'password') )
			.end (err, res) ->
				expect( res.status ).to.equal( 400 )
				done()


	it 'should verify a user after sign up', (done) ->
		userRaw = global.CONF().dataGenerator.getUsers(1)[0]

		models.user.findOne {email: userRaw.email}, (err, user) ->
			expect( err ).to.be.null
			expect( user.token ).to.exist
			agent
				.post( "#{USERS_URL}/verify" )
				.send({ token: user.token })
				.end (err, res) ->
					expect( res.status ).to.equal( 200 )
					expect( res.body._id ).to.exist

					models.user.findOne {_id:res.body._id}, (err, user) ->
						expect( err ).to.be.null
						expect( user.status ).to.equal('verified')
						done()


	it 'should log in a verified user', (done) ->
		userRaw = global.CONF().dataGenerator.getUsers(1)[0]
		agent
			.post( "#{USERS_URL}/login" )
			.send( _.pick(userRaw, 'username', 'password') )
			.end (err, res) ->
				expect( res.status ).to.equal( 200 )
				expect( res.body._id ).to.exist
				done()


	it 'should log out a user', (done) ->
		agent
			.post( "#{USERS_URL}/logout" )
			.end (err, res) ->
				expect( res.status ).to.equal( 200 )
				done()


