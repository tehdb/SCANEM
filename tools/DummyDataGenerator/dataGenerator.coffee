_ = require('lodash')
ObjectID = require('mongodb').ObjectID
hat = require('hat')


COLORS = [
	{
		key: 'white'
		rgb: {	r: 255, g: 255, b: 255 }
	},{
		key: 'red'
		rgb: {	r: 255, g: 0, b: 0 }
	},{
		key: 'green'
		rgb: {	r: 0, g: 255, b: 0 }
	},{
		key: 'blue'
		rgb: {	r: 0, g: 0, b: 255 }
	}, {
		key: 'gray',
		rgb: {	r: 190, g: 190, b: 190 }
	}, {
		key: 'magenta',
		rgb: {	r: 255, g: 0, b: 255 }
	}, {
		key: 'black',
		rgb: {	r: 0, g: 0, b: 0 }
	}
]

SIZES = [
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


module.exports =
	getRandomCats: (max) ->

		max = max or CATS.length
		max = if max > CATS.length then CATS.length else max

		return _.shuffle( _.cloneDeep(cats) ).slice(0, _.random(1, max) )


	getRandomColors: ->

		return _.sortBy( _.shuffle( _.cloneDeep(COLORS)).slice(0, _.random(1,COLORS.length) ), 'key' )

	getRandomSizes: ->
		return _.sortBy( _.shuffle( _.cloneDeep(SIZES)).slice(0, _.random(1,SIZES.length) ), 'width' )

	getProducts: ( amount )->
		c = this
		products = []


		for pIdx in [1..amount]
			p =
				title: "Test Product -"
				ean: hat()
				colors: c.getRandomColors()
				sizes: c.getRandomSizes()
				prices: []
				imgs: []
				cats: []
				# cats: ['testcat'].concat( c.getRandomCats(2) )
				# tags: _.shuffle( _.cloneDeep(tags)).slice(0, _.random(1,tags.length) )

			# generate colors
			_.each p.colors, (c) ->
				c._id = new ObjectID()
				p.title += " #{c.key}"

			p.title += " -"

			# generate sizes and prices
			_.each p.sizes, (s) ->
				s._id = new ObjectID()
				p.title += " #{s.width}x#{s.height}"

				p.prices.push({
					price: s.price
					ref: {size: s._id}
				})
				delete s.price

			# generate images
			for color,imgIdx in p.colors
				imgColors = _.sortBy( _.shuffle( p.colors ).slice(0, _.random(1,p.colors.length) ), 'key' )
				imgColorIds = []
				_.each imgColors, (c) -> imgColorIds.push( c._id )
				p.imgs.push({
					src: "#{pIdx}-#{imgIdx}.jpg"
					colors: imgColorIds
					ori: 'landscape'
				})

			products.push(p)

		return products

