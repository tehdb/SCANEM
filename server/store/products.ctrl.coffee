_ = require('lodash')
# Product = require( "#{__dirname}/product.mdl" )

mongoose = require('mongoose')
ObjectId = mongoose.Types.ObjectId

ProductMdl = mongoose.model('Product')
CategoryMdl = mongoose.model('Category')

util = require('util')
# console.log ObjectId
# console.log ProductModel
# console.log Product.findByColorKey

module.exports = () ->
	return x =

		# insert one or array of products, returns array
		insert: (req, res, next) ->
			ProductMdl.create req.body, (err, p...) -> # p... because create returns a list of params
				return next(err) if err
				res.json( p )

		update: (req, res, next) ->
			productData = req.body
			ProductMdl.findOne {_id:productData._id}, (err, p ) ->
				return next(err) if err
				updatedProduct = _.extend( p, productData )
				updatedProduct.save (err,p) ->
					return next(err) if err
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
				ProductMdl.findOne {_id:id}, (err, p) ->
					return next(err) if err
					res.json(p)

			else
				# TODO: cache the query
				query = {}
				limit = req.query.limit or 10
				page = req.query.page or 0

				if req.query.color?
					colorsArr = []
					colorsKeys = req.query.color.split(';')
					colorsArr.push({ key: key}) for key in colorsKeys
					query.colors = { $elemMatch: { $or: colorsArr } }


				if req.query.size?
					sizesArr = []
					sizesVals = req.query.size.split(';')
					for v in sizesVals
						s = v.split('x')
						sizesArr.push({ width: s[0], height: s[1] })

					query.sizes = { $elemMatch: { $or: sizesArr } }

				if req.query.q?
					query.title = new RegExp(req.query.q, "i")


				if req.query.cat?
					# console.log req.query.cat
					# catObjId = ObjectId(req.query.cat)
					# console.log catObjId

					# CategoryMdl.findOne {_id: catObjId}, (err, cat) ->
					CategoryMdl.findOne {_id: req.query.cat}, (err, cat) ->
						return next(err) if err

						query._id = { $in: cat.items }


						ProductMdl
							.find( query )
							.limit( limit )
							.skip( page*limit )
							.exec (err, pArr) ->
								return next(err) if err
								res.json(pArr)


				else

					ProductMdl
						.find( query )
						.limit( limit )
						.skip( page*limit )
						.exec (err, pArr) ->
							return next(err) if err
							res.json(pArr)



