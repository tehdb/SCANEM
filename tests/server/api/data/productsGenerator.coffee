_ = require('lodash')
ObjectID = require('mongodb').ObjectID
hat = require('hat')

module.exports =
	getProducts: (start = 0, end = 10)->
		products = []
		colors = [
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

		for pIdx in [start..end]
			p =
				title: "Product #{pIdx} -"
				ean: hat()
				colors: null
				sizes: null
				prices: []
				imgs: []
				cats: ['testcat']

			# generate colors
			p.colors = _.sortBy( _.shuffle( _.cloneDeep(colors)).slice(0, _.random(1,colors.length) ), 'key' )
			_.each p.colors, (c) ->
				c._id = new ObjectID()
				p.title += " #{c.key}"

			p.title += " -"

			# generate sizes and prices
			p.sizes = _.sortBy( _.shuffle( _.cloneDeep(sizes)).slice(0, _.random(1,sizes.length) ), 'width' )
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

