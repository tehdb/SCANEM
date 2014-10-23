
angular.module('app.auth').classy.controller({
	name: 'LoginModalCtrl'
	inject: {
		'$scope' : '$'
		'$modalInstance': '$mi'
		# 'md5' : '.'
		'AuthSrvc': 'as'
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



			userData = _.pick( c.$.login, 'username', 'password' )
			# userData.password = c.md5.createHash( userData.password )

			# console.log userData
			#
			c.as.auth( userData )

		c.$.doSignup = ($event) ->
			if $event
				$event.preventDefault()
				$event.stopPropagation()

			c.$mi.close( {status:'signup' });

})
