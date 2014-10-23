
angular.module('app.auth').classy.controller({
	name: 'SignupModalCtrl'
	inject: {
		'$scope' : '$'
		'$modalInstance': '$mi'
	}
	init: ->
		c = @

		c.$.login = ($event) ->
			if $event
				$event.preventDefault()
				$event.stopPropagation()

			c.$mi.close({status:'login'})

})
