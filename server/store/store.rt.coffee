# PWD = process.env.PWD

module.exports = (router, eventEmmiter) ->
	prodsCtrl = require("#{__dirname}/products.ctrl")()
	catsCtrl = require("#{__dirname}/categories.ctrl")()
	# console.log ctrl.create


	# /store/products
	###
  	create a product
  	post - /store/products/
  	{}

  ###
	router
		.route('/store/products/:id?') 		# multiple route handler allowed here
			.post( prodsCtrl.insert ) 			# insert product
			.put( prodsCtrl.update ) 			# update product
			.get( prodsCtrl.select ) 		# select a product

	router
		.route('/store/categories/:id?')
			.post( catsCtrl.insert )
			.put( catsCtrl.update )
			.get( catsCtrl.select )
			.delete( catsCtrl.remove )

	###
  	update a product
  	put - /store/products/:id
  	finde one by id, extend data and call save method

  	delete a product
  	delete - /store/products/:id

  	select a single product
  	get - /store/products/:id

  	select multiple products
  	get - /store/products
  	supplies a list of popular products

  	get params
  		count - amount of products
  		page - page number for pagination
  		q - filter by query
  		cat - filter by category (multiple comma separated)
  		color - filter by color (multiple comma separated)
  		size - filter by size ([width]x[height] (multiple comma separated)

	###

	# router
	# 	# .route('/store/p/:pid')
	# 	# .get( ctrl.selectById )
	# 	.route('/store/product/:id')
	# 	.get( (req, res) ->
	# 		console.log "select product"
	# 		res.json( {msg: "ok"})
	# 	)






	return router

