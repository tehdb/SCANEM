angular
	.module('app.auth')
	.factory('AuthSrvc', [
		'Restangular'
		'md5'
		(ra, md5) ->

			res =
				login: (userData) ->

					base = ra.all('user/login')

					# encrypt password
					userData.password = md5.createHash( userData.password )

					return base.post( userData )

				signup: (userData) ->
					# base =
					base = ra.all('user/signup')
					userData.password = md5.createHash( userData.password )
					return base.post( userData )

				verify: (token) ->
					base = ra.all('user/verify')
					return base.post( token: token )

			return res
])