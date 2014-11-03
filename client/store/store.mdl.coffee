angular
	.module('app.store', [
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
				# .when '/o/',


				.when '/f/',
					controller: 	'ListViewCtrl'
					templateUrl: 	'/partials/store/list.html'

				.when '/p/:pid',
					controller: 	'SingleViewCtrl'
					templateUrl: 	'/partials/store/single.html'



	])
