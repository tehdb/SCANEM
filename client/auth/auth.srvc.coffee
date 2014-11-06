angular
	.module('app.auth')
	.factory('AuthSrvc', [
		'$q'
		'Restangular'
		'md5'
		($q, ra, md5) ->

			_user = window.bootstrappedUserObject or null

			res =
				signup: (userData) ->
					base = ra.all('user/signup')
					userData.password = md5.createHash( userData.password )
					return base.post( userData )

				verify: (token) ->
					base = ra.all('user/verify')
					return base.post( token: token )

				login: (userData) ->
					defer = $q.defer()
					base = ra.all('user/login')
					# encrypt password
					userData.password = md5.createHash( userData.password )

					# base.post( userData ).then(
					# 	(user) ->

					# 	,(err) ->

					# )
					# return base.post( userData )
					#
					base.post( userData ).then(
						(data) ->
							_user = data
							defer.resolve( data )
					,
						(err) -> defer.reject( err )
					)
					return defer.promise

				logout : ->
					base = ra.all('user/logout')
					return base.post()

				isLogedIn: ->
					return _user?

				getUser: ->
					return _user

			return res
])