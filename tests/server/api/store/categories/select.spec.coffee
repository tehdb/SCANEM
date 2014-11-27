PWD 	= process.env.PWD
_ 		= require('lodash')
expect 	= require('chai').expect
sinon 	= require('sinon')

conf = require("#{PWD}/server/config/config")

prodsUrl = "#{conf.apiUrl}/store/products"
catsUrl = "#{conf.apiUrl}/store/categories"

# db = require('monk')(conf.db)
# collProducts = db.get('products')


superagent = require('superagent')
agent = superagent.agent()

CatData = { name: 'Testcategory 1' }
cat = null

describe 'api categories select functionality', ->

	# before (done) ->
	# 	agent.post(catsUrl).send(catData).end (err, res) ->
	# 		expect( err ).to.be.null
	# 		expect(res.status).to.equal(200)
	# 		cat = res.body
	# 		done()

	# after (done) ->
	# 	done()


	xit 'should select a category by id', (done) ->
		url = "#{catsUrl}/5475fccceadcd30000d2bb60"
		agent.get(url).end (err, res) ->
				expect( err ).to.be.null
				# console.log res.body
				done()


	it 'should create a new category', (done) ->
		catData = {
			name: 'Testcategory 1'
		}

		agent.post(catsUrl).send(catData).end (err, res) ->
			expect( err ).to.be.null
			expect(res.status).to.equal(200)
			done()

	# it 'should not create a category if data is invalid', ->
	# 	agent.post(catsUrl).send(catData).end (err, res) ->
	# 		expect( err ).to.be.null
	# 		# expect(res.status).to.equal(200)
	# 		done()
