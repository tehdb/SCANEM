# PWD = process.env.PWD

module.exports = (router, eventEmmiter) ->
	ctrl = require("#{__dirname}/products.ctrl")()

	# console.log ctrl.create


	router
		# .route('/store/p/:pid')
		# .get( ctrl.selectById )
		.route('/store/product/:id')
		.get( (req, res) ->
			console.log "select product"
			res.json( {msg: "ok"})
		)




	router
		.route('/store/product/insert')
		.post( ctrl.create )			# multiple route handler allowed here

	return router

