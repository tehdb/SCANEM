angular
	.module('app.products', [
		'ngRoute'
		'classy'
	]).config([
		'$routeProvider'
		($rp) ->


			# /p/ 							- overview of the cats
			# /p/pid 						- product page
			# /f/?key1=val1&key2-val2 		- filter page
			#
			#	common
			# 	- q = query
			# 	- s = sort
			# 	- c = category
			# 	- t = tag
			#
			# 	specific
			# 	- size 	= size of the product
			# 	- color = color or colors of the product ; separated
			# 	- price = price or pricerange

			$rp

				.when '/f/',
					controller: 	'FilterPageCtrl'
					templateUrl: 	'/partials/products/filter-page.html'

				.when '/p/:pid?',
					controller: 	'ProductPageCtrl'
					templateUrl: 	'/partials/products/product-page.html'



	])
