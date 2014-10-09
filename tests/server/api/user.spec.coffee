
_ 			= require 'lodash'
request 	= require('superagent')
chai 		= require 'chai'
expect 		= chai.expect
sinon 		= require('sinon')

describe 'users api', ->

	it 'should retrieve users json array from server', (done) ->
		request
			.get('http://localhost:3030/api/users?m=-1&p=-1')
			.end (err, res) ->
				expect( res.body ).to.be.an 'array'
				done()

	it 'should retrieve limited amount of users', (done) ->

		amountOfUsers = 10

		request
			.get("http://localhost:3030/api/users?m=#{amountOfUsers}&p=-1")
			.end (err, res) ->
				expect( res.body.length ).to.equal amountOfUsers
				done()

	it 'should retrieve filtered list of users', (done) ->
		query = 'Kyle'
		prop = 'name'

		request
			.get("http://localhost:3030/api/users?q=#{query}&p=#{prop}")
			.end (err, res) ->
				obj = {}
				obj[prop] = query

				expect( _.every(res.body, obj ) ).to.be.true
				done()
