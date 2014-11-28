_ = require('lodash')
# Product = require( "#{__dirname}/product.mdl" )

Category = require('mongoose').model('Category')

# console.log ProductModel
# console.log Product.findByColorKey

module.exports = () ->
	return o =
		select: (req, res, next) ->

			id = req.params.id

			if id?
				Category.findOne {_id:id}, (err, cat) ->
					return next(err) if err
					res.json(cat)
			else

				if req.query.q?
					regex = new RegExp(req.query.q, "i")
					Category.find {name: regex}, (err, cats) ->
						return next(err) if err
						res.json(cats)

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

		remove: (req, res, next) ->
			catData = req.body

			cat = Category.findOne {_id: catData._id}, (err, cat ) ->
				return next(err) if err

				cat.remove (err, rep) ->
					return next(err) if err
					res.json(rep)






