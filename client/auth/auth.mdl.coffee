angular
	.module('app.auth', [
		'ngRoute'
		'classy'
	])
	.namespace()
	.config([
		'$routeProvider'
		($rp) ->

			$rp
				.when '/verify/:token?',
					controller: 	'VerifyPageCtrl'
					templateUrl: 	'/partials/auth/verify-page.html'
					resolve:
						user: [
							'$route'
							'app.auth.AuthSrvc'
							($r, as) -> return as.verify( $r.current.params.token )
						]

				.when '/profile/:username',
					controller: 	'ProfilePageCtrl'
					templateUrl: 	'/partials/auth/profile-page.html'
					resolve:
						user: [
							'$q'
							'$route'
							'$timeout'
							'app.auth.AuthSrvc'
							($q, $r, $to, as) ->
								dfd = $q.defer()

								$to( ->
									user = as.getUser()
									if user?.username is $r.current.params.username
										dfd.resolve( user )
									else
										dfd.reject( )
								, 0)

								return dfd.promise
						]
	])
