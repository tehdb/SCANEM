
angular.module('app.auth').classy.controller({
	name: 'SignupModalCtrl'
	inject: {
		'$scope' : '$'
		'$modalInstance': '$mi'
		'AuthSrvc' : 'as'
	}
	init: ->
		c = @

		c.$.doSignup = ($event) ->
			if $event
				$event.preventDefault()
				$event.stopPropagation()


			c.as.signup( c.$.signup ).then(
				(data) ->
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
