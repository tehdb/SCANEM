
angular.module('app.auth').classy.controller({
	name: 'LoginModalCtrl'
	inject: {
		'$scope' : '$'
		'$modalInstance': '$mi'
		# 'md5' : '.'
		'app.auth.AuthSrvc': 'as'
	}
	init: ->
		c = @

		# c.$.vm =
		# 	username:
		# 	password:

		c.$.doLogin = ($event) ->
			if $event
				$event.preventDefault()
				$event.stopPropagation()



			# userData = _.pick( c.$.login, 'username', 'password' )
			# userData.password = c.md5.createHash( userData.password )

			# console.log userData
			#
			# c.as.auth( userData )
			#console.log c.$.login

			c.as.login( angular.copy( c.$.login) ).then(
				(data) ->
					c.$mi.close( {status: 'login', user: data})
					# console.log user
				,(err) ->
					console.log err
			)

		c.$.doSignup = ($event) ->
			if $event
				$event.preventDefault()
				$event.stopPropagation()

			c.$mi.close( {status:'signup' });

})
