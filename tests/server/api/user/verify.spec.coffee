
_ 			= require('lodash')
expect 		= require('chai').expect
sinon 		= require('sinon')

# request 	= require('superagent')
# request = require('supertest');
superagent = require('superagent');
agent = superagent.agent();

db = require('monk')('localhost/SCANEM')
URL = 'http://localhost:3030/api/user'

# server = request.agent( URL );

UserInput =
	email: 'test@user.com'
	username: 'testuser'
	password: '123123123123'

User = null


describe 'api user verify', ->

	before (done) ->
		agent
			.post( "#{URL}/signup" )
			.send( UserInput )
			# .expect( 200 )
			.end (err, res) ->
				expect( res.status ).to.equal( 200 )
				User = res.body
				done()


	# clean up db
	after (done) ->
		users = db.get('users')
		users.remove {_id: User._id}, (err ) ->
			expect( err ).to.be.null
			done()

	it 'should verify a user after sign up', (done) ->
		agent
			.post( "#{URL}/verify" )
			.send({ token: User.token })
			# .expect( 200 )
			.end (err, res) ->
				expect( res.status ).to.equal( 200 )
				expect( res.body._id ).to.exist
				done()


