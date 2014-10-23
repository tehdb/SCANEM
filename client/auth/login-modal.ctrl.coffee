
angular.module('app.auth').classy.controller({
	name: 'LoginModalCtrl'
	inject: {
		'$scope' : '$'
		'$modalInstance': '$mi'
	}
	init: ->
		c = @


		c.$.signup = ($event) ->
			if $event
				$event.preventDefault()
				$event.stopPropagation()

			c.$mi.close( {status:'signup' });

})
