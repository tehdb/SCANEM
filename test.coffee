_ = require('lodash')
ObjectID = require('mongodb').ObjectID
hat = require('hat')

maxItems = 1

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
		price: 80.6
	}, {
		width: 100
		height: 70
		price: 100.7
	}, {
		width: 120
		height: 80
		price: 120.8
	}, {
		width: 150
		height: 100
		price: 150.1
	}
]

for pIdx in [0..maxItems]
	p =
		title: "Product #{pIdx} -"
		ean: hat()
		colors: null
		sizes: null
		prices: []
		imgs: []

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

	for color,imgIdx in p.colors
		# generate images
		imgColors = _.sortBy( _.shuffle( p.colors ).slice(0, _.random(1,p.colors.length) ), 'key' )
		imgColorIds = []
		_.each imgColors, (c) -> imgColorIds.push( c._id )
		p.imgs.push({
			src: "#{pIdx}-#{imgIdx}.jpg"
			colors: imgColorIds
			ori: 'landscape'
		})

		# console.log imgColors
		# console.log _.pluck( imgColors, '_id')
		# imgColorsKeys = []
		# imgColorIds = []
		# _.each imgColors, (c) ->
		# 	imgColorsKeys.push( c.key )
		# 	imgColorIds.push( c._id )



	console.log JSON.stringify( p , null, '\t')
