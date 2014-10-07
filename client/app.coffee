angular.module('jsworkshop', [
	'ngRoute'
	]).config([
		'$routeProvider'
		'$locationProvider'
		( $rp, $lp ) ->

			$rp
				# .when '/profile',
				# 	template: '/partials/profile.html'
				# 	controller: 'ProfileCtrl'

				.otherwise
					redirectTo: '/index'

			return
])
