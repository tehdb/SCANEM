# PWD = process.env.PWD

module.exports = (router, eventEmmiter) ->
	ctrl = require("#{__dirname}/products.ctrl")()

	# console.log ctrl.create


	# /store/products
	###
  	create a product
  	post - /store/products/
  	{}

  ###
	router
		.route('/store/products/:id?') 		# multiple route handler allowed here
		.post( ctrl.insert ) 			# insert product
		.put( ctrl.update ) 			# update product
		.get( ctrl.select ) 		# select a product

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

