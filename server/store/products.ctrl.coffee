
Product = require( "#{__dirname}/product.mdl" )


module.exports = () ->
	return x =
		selectById: (req, res, next) ->
			pid = req.params.pid

			res.send( pid )

		create: (req, res, next) ->

			# console.log req.body
			# res.send("ok")

			# console.log p
			p = new Product(req.body)
			p.save ( err, p) ->
				return res.status(400).json({ 'reason' : err }) if err
				res.json( p )

