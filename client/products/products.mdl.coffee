angular
	.module('app.products', [
		'ngRoute'
		'classy'
	]).config([
		'$routeProvider'
		($rp) ->


			# domain.com/p/PID
			# domain.com/f/?
			# 	q=XXX&	- query
			# 	c=XXX&	- category
			# 	t=XXX&	- tag
			# 	s=XXX&	- sort
			# 	size=123&color=white&price=123.13
			#
			# domain.com/products/search/xxx
			# domain.com/products/category/xxx
			# domain.com/products/tag/xxx
			# domain.com/products/product/xxx
			#
			#
			#
			#
			#

			$rp

				# .when '/products/search/:query',

				# .when '/products/category/:cat',

				# .when '/products/tag/:tag',

				# .when '/products/product/:pid',
				.when '/f/',
					controller: 	'FilterPageCtrl'
					templateUrl: 	'/partials/products/filter-page.html'

				.when '/p/:pid',
					controller: 	'ProductPageCtrl'
					templateUrl: 	'/partials/products/product-page.html'



	])
