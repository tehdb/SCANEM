angular.module('jsworkshop', [
	'ngRoute'
	]).config([
		'$routeProvider'
		'$locationProvider'
		( $rp, $lp ) ->

			$rp
				.when '/index',
					template: 'public/index.html'
					controller: 'ProfileCtrl'

				.otherwise
					redirectTo: '/index'

			return
])