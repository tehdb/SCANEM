angular
	.module('app.auth')
	.factory('AuthSrvc', [
		'Restangular'
		'md5'
		(ra, md5) ->
			base = ra.all('users')

			res =
				auth: (userData) ->

					# encrypt password
					userData.password = md5.createHash( userData.password )


					# base.post
					console.log "***********"
					console.log( userData )
					console.log "***********"

			return res
])