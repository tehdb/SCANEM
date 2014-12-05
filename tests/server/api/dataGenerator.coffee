_ = require('lodash')


ObjectID = require('mongodb').ObjectID
hat = require('hat')








CATS = ->
	[
		{ name: 'Testcategory 1' }
		{ name: 'Testcategory 2' }
		{ name: 'Testcategory 3' }
		{ name: 'Testcategory 4' }
		{ name: 'Testcategory 5' }
		{ name: 'Testcategory 6' }
		{ name: 'Testcategory 7' }
	]


module.exports =

	getCats: ->
		return CATS()

	getUsers: (count) ->
		users = [
			{
				email: 'test1@user.com'
				username: 'testuser1'
				password: '123123123123'

			}, {
				email: 'test2@user.com'
				username: 'testuser2'
				password: '123123123123'
			}
		]

		count = count or users.length

		return users.splice(0, count)

	getRandomCats: (max) ->

		cats = CATS()
		max = max or cats.length
		max = if max > cats.length then cats.length else max

		return _.shuffle( cats ).slice(0, _.random(1, max) )


	getRandomColors: (max) ->

		colors = ['white','red','green','blue','gray','magenta','black']

		max = max or colors.length
		max = if max > colors.length then colors.length else max

		return _.shuffle( colors ).slice(0, _.random(1,max) )


	getRandomSizes: (max) ->
		sizes = [
			{
				width: 80
				height: 60
				price: 80.60
			}, {
				width: 100
				height: 70
				price: 100.70
			}, {
				width: 120
				height: 80
				price: 120.80
			}, {
				width: 150
				height: 100
				price: 150.10
			}
		]

		max = max or sizes.length
		max = if max > sizes.length then sizes.length else max
		return _.sortBy( _.shuffle( sizes ).slice(0, _.random(1,max) ), 'width' )


	getProds: ( amount = 10 )->
		c = this
		products = []




		for pIdx in [1..amount]

			pSize = c.getRandomSizes(1)[0]

			p =
				title: "Test Product - #{pIdx}"
				ean: hat()
				price:
					amount: pSize.price
					currency: 'EUR'
				imgs: []
				cats: []
				attrs: [
					{ key: 'width', val: pSize.width }
					{ key: 'height', val: pSize.height }
					# { key: 'color', val: c.getRandomColors(1)[0] }
				]


			# add random colors to attributes
			for color in c.getRandomColors()
				p.attrs.push({
					key: 'color'
					val: color
				})

				# tags: _.shuffle( _.cloneDeep(tags)).slice(0, _.random(1,tags.length) )

			# generate colors
			# _.each p.colors, (c) ->
			# 	c._id = new ObjectID()
			# 	p.title += " #{c.key}"

			# p.title += " -"

			# generate sizes and prices
			# _.each p.sizes, (s) ->
			# 	s._id = new ObjectID()
			# 	p.title += " #{s.width}x#{s.height}"

			# 	p.prices.push({
			# 		price: s.price
			# 		ref: {size: s._id}
			# 	})
			# 	delete s.price

			# generate images
			# for color,imgIdx in p.colors
			# 	imgColors = _.sortBy( _.shuffle( p.colors ).slice(0, _.random(1,p.colors.length) ), 'key' )
			# 	imgColorIds = []
			# 	_.each imgColors, (c) -> imgColorIds.push( c._id )
			# 	p.imgs.push({
			# 		src: "#{pIdx}-#{imgIdx}.jpg"
			# 		colors: imgColorIds
			# 		ori: 'landscape'
			# 	})

			products.push(p)

		return products

