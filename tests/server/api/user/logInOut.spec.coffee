
_ 			= require('lodash')
expect 		= require('chai').expect
sinon 		= require('sinon')

superagent = require('superagent');
agent = superagent.agent();

db = require('monk')('localhost/SCANEM')
URL = 'http://localhost:3030/api/user'


UserInput =
	email: 'test@user.com'
	username: 'testuser'
	password: '123123123123'

User = null


describe 'api user log in / log out', ->

	before (done) ->
		agent
			.post( "#{URL}/signup" )
			.send( UserInput )
			# .expect( 200 )
			.end (err, res) ->
				expect( res.status ).to.equal( 200 )
				User = res.body

				agent
					.post( "#{URL}/verify" )
					.send({ token: User.token })
					.end (err, res) ->
						expect( res.status ).to.equal( 200 )
						expect( res.body._id ).to.exist
						done()

	# clean up db
	after (done) ->
		users = db.get('users')
		users.remove {_id: User._id}, (err ) ->
			expect( err ).to.be.null
			done()


	it 'should log in a user', (done) ->
		agent
			.post( "#{URL}/login" )
			.send( _.pick(UserInput, 'username', 'password') )
			.end (err, res) ->
				expect( res.status ).to.equal( 200 )
				expect( res.body._id ).to.exist
				done()

	it 'should log out a user', (done) ->
		agent
			.post( "#{URL}/logout" )
			.end (err, res) ->
				expect( res.status ).to.equal( 200 )
				done()


