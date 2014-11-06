
angular.module('app.auth').classy.controller({
	name: 'SignupModalCtrl'
	inject: {
		'$scope' : '$'
		'$modalInstance': '$mi'
		'app.auth.AuthSrvc' : 'as'
	}
	init: ->
		c = @

		c.$.vm =
			signedup : false

		c.$.doSignup = ($event) ->
			if $event
				$event.preventDefault()
				$event.stopPropagation()


			c.as.signup( c.$.signup ).then(
				(data) ->
					c.$.vm.signedup = true
					console.log data
				,(err) ->
					console.log err
			)



		c.$.doLogin = ($event) ->
			if $event
				$event.preventDefault()
				$event.stopPropagation()

			c.$mi.close({status:'login'})

})
