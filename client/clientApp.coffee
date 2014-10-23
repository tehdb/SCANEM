angular
	.module('app', [

		# Angular modules
		'ngRoute'
		'ngCookies'

		# Custom modules
		'app.auth'

		# 3rd Party Modules
		'classy'
		'restangular'
		'ui.bootstrap'
		'ui.select'
		'pascalprecht.translate'
		'angular-md5'
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
		'$translateProvider'
		'RestangularProvider'
		'routes'
		'uiSelectConfig'
		( $rp, $lp, $tp, rp, routes, usc ) ->
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


			# angular-translate
			$tp.useUrlLoader('/api/i18n')
			$tp.preferredLanguage('en_GB')
			$tp.fallbackLanguage('en_GB')
			$tp.usePostCompiling(true)
			$tp.useLocalStorage()
			# $tp.useCookieStorage()

			return
	])

