_ = require('lodash')
Product = require( "#{__dirname}/product.mdl" )


module.exports = () ->
	return x =
		selectById: (req, res, next) ->
			pid = req.params.pid

			res.send( pid )


		# TODO: store multiple products
		insert: (req, res, next) ->
			p = new Product(req.body)
			p.save ( err, p) ->
				return res.status(400).json({ 'reason' : err }) if err
				res.json( p )

		update: (req, res, next) ->
			productData = req.body
			Product.findOne {_id:productData._id}, (err, p ) ->
				return res.status(400).json({ 'reason' : err }) if err
				updatedProduct = _.extend( p, productData )
				updatedProduct.save (err,p) ->
					return res.status(400).json({ 'reason' : err }) if err
					res.json(p)

		# get params
			# count - amount of products
			# page - page number for pagination
			# q - filter by query
			# cat - filter by category (multiple comma separated)
			# color - filter by color (multiple comma separated)
			# size - filter by size ([width]x[height] (multiple comma separated)
		select: (req, res, next) ->

			id = req.params.id

			if id?
				Product.findOne {_id:id}, (err, p) ->
					return res.status(400).json({ 'reason' : err }) if err
					res.json(p)

			else
				if req.query.color?
					# Product.find { vars: { colors: { $in: [req.query.color] }}}, (err, pArr) ->

					# 	return res.status(400).json({ 'reason' : err }) if err
					# 	res.send(pArr)
					Product.find {vars: $in: {width: 80}}, (err, p) ->
						return res.status(400).json({ 'reason' : err }) if err
						console.log p
						res.json(p)


