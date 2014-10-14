angular.module('app', [
	'ngRoute'
	'classy'
	'restangular'
])

.config([
		'$routeProvider'
		'$locationProvider'
		'RestangularProvider'
		( $rp, $lp, rp ) ->

			$rp
				.when '/',
					templateUrl: '/partials/home.html'
					controller: 'HomeCtrl'

				.when '/user/:email',
					templateUrl: '/partials/profile.html'
					controller: 'ProfileCtrl'

				.otherwise
					redirectTo: '/'

			$lp.html5Mode( true )
			$lp.hashPrefix( '!' )

			rp.setBaseUrl('/api')

			return
])


# .run(['breeze', (breeze) ->
# 	#
# ])
