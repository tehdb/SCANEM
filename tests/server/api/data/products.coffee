ObjectID = require('mongodb').ObjectID




p1 = ->
	c = {
		title: 'test product 1 red green blue 80x60 100x80'
		ean: 	'1'

		colors: [
			{
				_id: new ObjectID()
				key: 'red'
				val: {	r: 255, g: 0, b: 0 }
			},{
				_id: new ObjectID()
				key: 'green'
				val: {	r: 0, g: 255, b: 0 }
			},{
				_id: new ObjectID()
				key: 'blue'
				val: {	r: 0, g: 0, b: 255 }
			}
		]

		sizes: [
			{
				_id: new ObjectID()
				width: 80
				height: 60
			}, {
				_id: new ObjectID()
				width: 100
				height: 80
			}
		]
	}

	c.imgs = [
		{
			src: '1-1.jpg'
			ori: 'landscape'
			colors: [ c.colors[0]._id ]
			sizes: [ c.sizes[0]._id, c.sizes[1]._id ]
		},{
			src: '1-2.jpg'
			ori: 'landscape'
			colors: [ c.colors[1]._id ]
			sizes: [ c.sizes[0]._id, c.sizes[1]._id ]
		},{
			src: '1-3.jpg'
			ori: 'landscape'
			colors: [ c.colors[2]._id ]
			sizes: [ c.sizes[0]._id, c.sizes[1]._id ]
		}
	]

	c.prices = [
		{
			price: 80.60
			ref: { size: c.sizes[0]._id }
		},{
			price: 100.80
			ref: { size: c.sizes[1]._id }
		}
	]
	return c

p2 = ->
	c = {
		title: 'test product 2 red green blue 80x60 100x80'
		ean: 	'2'

		colors: [
			{
				_id: new ObjectID()
				key: 'red'
				val: {	r: 255, g: 0, b: 0 }
			},{
				_id: new ObjectID()
				key: 'green'
				val: {	r: 0, g: 255, b: 0 }
			},{
				_id: new ObjectID()
				key: 'blue'
				val: {	r: 0, g: 0, b: 255 }
			}
		]

		sizes: [
			{
				_id: new ObjectID()
				width: 80
				height: 60
			}, {
				_id: new ObjectID()
				width: 100
				height: 80
			}
		]
	}

	c.imgs = [
		{
			src: '2-1.jpg'
			ori: 'landscape'
			colors: [ c.colors[0]._id ]
			sizes: [ c.sizes[0]._id, c.sizes[1]._id ]
		},{
			src: '2-2.jpg'
			ori: 'landscape'
			colors: [ c.colors[1]._id ]
			sizes: [ c.sizes[0]._id, c.sizes[1]._id ]
		},{
			src: '2-3.jpg'
			ori: 'landscape'
			colors: [ c.colors[2]._id ]
			sizes: [ c.sizes[0]._id, c.sizes[1]._id ]
		}
	]

	c.prices = [
		{
			price: 80.60
			ref: { size: c.sizes[0]._id }
		},{
			price: 100.80
			ref: { size: c.sizes[1]._id }
		}
	]
	return c

p3 = ->
	c = {
		title: 'test product 3 red green blue 80x60 100x80'
		ean: 	'3'

		colors: [
			{
				_id: new ObjectID()
				key: 'red'
				val: {	r: 255, g: 0, b: 0 }
			},{
				_id: new ObjectID()
				key: 'green'
				val: {	r: 0, g: 255, b: 0 }
			},{
				_id: new ObjectID()
				key: 'blue'
				val: {	r: 0, g: 0, b: 255 }
			}
		]

		sizes: [
			{
				_id: new ObjectID()
				width: 80
				height: 60
			}, {
				_id: new ObjectID()
				width: 100
				height: 80
			}
		]
	}

	c.imgs = [
		{
			src: '3-1.jpg'
			ori: 'landscape'
			colors: [ c.colors[0]._id ]
			sizes: [ c.sizes[0]._id, c.sizes[1]._id ]
		},{
			src: '3-2.jpg'
			ori: 'landscape'
			colors: [ c.colors[1]._id ]
			sizes: [ c.sizes[0]._id, c.sizes[1]._id ]
		},{
			src: '3-3.jpg'
			ori: 'landscape'
			colors: [ c.colors[2]._id ]
			sizes: [ c.sizes[0]._id, c.sizes[1]._id ]
		}
	]

	c.prices = [
		{
			price: 80.60
			ref: { size: c.sizes[0]._id }
		},{
			price: 100.80
			ref: { size: c.sizes[1]._id }
		}
	]
	return c




module.exports =
	multipleProducts: [p1(), p2()]
	singleProduct: p3()