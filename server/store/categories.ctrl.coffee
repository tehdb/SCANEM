_ = require('lodash')
# Product = require( "#{__dirname}/product.mdl" )

Category = require('mongoose').model('Category')

# console.log ProductModel
# console.log Product.findByColorKey

module.exports = () ->
	return x =

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
				Category.findOne {_id:id}, (err, doc) ->
					return next(err) if err
					res.json(doc)
			else
				next({reason: "nothing to select"})

		insert: (req, res, next ) ->

			Category.create req.body, (err, catsArr...) ->
				return next(err) if err
				res.json(catsArr)


		update: (req, res, next) ->
			catData = req.body

			Category.findOne {_id:catData._id}, (err, cat) ->
				return next(err) if err
				updatedCat = _.extend(cat, catData)
				updatedCat.save (err, cat) ->
					return next(err) if err
					res.json(cat)





