angular
	.module('app', [

		# Angular modules
		'ngRoute'

		# Custom modules
		'app.usermanager'

		# 3rd Party Modules
		'classy'
		'restangular'
		'ui.bootstrap'
		'ui.select'
	])

	# configure routes
	.constant('routes', [
		{
			url: '/'
			config:
				title: 			'home'
				# controller: 	'HomeCtrl'
				templateUrl: 	'/partials/layout/home.html'
				settings: 		{}
		}, {
			url: '/user/:email'
			config:
				title: 			'user'
				# controller: 	'ProfileCtrl'
				templateUrl: 	'/partials/profile.html'
				settings: 		{}

		}
	])

	# configure modules
	.config([
		'$routeProvider'
		'$locationProvider'
		'RestangularProvider'
		'routes'
		'uiSelectConfig'
		( $rp, $lp, rp, routes, usc ) ->
			routes.forEach (r) ->
				$rp.when( r.url, r.config )

			$rp.otherwise({ redirectTo: '/' })

			# activates html5 url mode
			$lp.html5Mode( true )
			$lp.hashPrefix( '!' )


			# restangular base api url
			rp.setBaseUrl('/api')

			# ui select config
			usc.theme = 'bootstrap'

			return
	])

