
_ 			= require('lodash')
expect 		= require('chai').expect
sinon 		= require('sinon')

superagent = require('superagent');
agent = superagent.agent();

db = require('monk')('localhost/SCANEM')
URL = 'http://localhost:3030/api/user'


USER_INPUT = _.constant({
	email: 'test@user.com'
	username: 'testuser'
	password: '123123123123'
})

# User = null
_users_db = db.get('users')
_user = null
_token = null


describe 'api user log in / log out', ->

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

					agent
						.post( "#{URL}/verify" )
						.send({ token: user.token })
						.end (err, res) ->
							expect( res.status ).to.equal( 200 )
							expect( res.body._id ).to.exist
							done()

	# clean up db
	after (done) ->
		_users_db.remove {_id: _user._id}, (err ) ->
			expect( err ).to.be.null
			done()


	it 'should log in a user', (done) ->
		agent
			.post( "#{URL}/login" )
			.send( _.pick(USER_INPUT(), 'username', 'password') )
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


