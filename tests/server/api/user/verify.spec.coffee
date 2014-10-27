
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

USER_INPUT = _.constant({
	email: 'test@user.com'
	username: 'testuser'
	password: '123123123123'
})

_users_db = db.get('users')
_user = null
_token = null

describe 'api user verify', ->

	before (done) ->
		agent
			.post( "#{URL}/signup" )
			.send( USER_INPUT() )
			# .expect( 200 )
			.end (err, res) ->
				expect( res.status ).to.equal( 200 )
				_user = res.body

				_users_db.findOne {_id: _user._id}, (err, user) ->
					expect( err ).to.be.null
					_token = user.token
					done()


	# clean up db
	after (done) ->
		_users_db.remove {_id: _user._id}, (err ) ->
			expect( err ).to.be.null
			done()

	it 'should verify a user after sign up', (done) ->
		agent
			.post( "#{URL}/verify" )
			.send({ token: _token })
			# .expect( 200 )
			.end (err, res) ->
				expect( res.status ).to.equal( 200 )
				expect( res.body._id ).to.exist
				done()


