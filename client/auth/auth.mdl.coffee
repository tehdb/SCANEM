angular
	.module('app.auth', [
		'ngRoute'
		'classy'
	]).config([
		'$routeProvider'
		($rp) ->

			$rp.when '/verify/:token?',
				controller: 	'VerifyPageCtrl'
				templateUrl: 	'/partials/auth/verify-page.html'
				resolve:
					user: [
						'$route'
						'AuthSrvc'
						($r, as) -> return as.verify( $r.current.params.token )
					]


	])
