angular
	.module('app.products', [
		'ngRoute'
		'classy'
	]).config([
		'$routeProvider'
		($rp) ->


			# domain.com/products
			# domain.com/products/search/xxx
			# domain.com/products/category/xxx
			# domain.com/products/tag/xxx
			# domain.com/products/product/xxx

			$rp

				# .when '/products/search/:query',

				# .when '/products/category/:cat',

				# .when '/products/tag/:tag',

				# .when '/products/product/:pid',

				.when '/products/',
					controller: 	'ProductsPageCtrl'
					templateUrl: 	'/partials/products/products-page.html'



	])
