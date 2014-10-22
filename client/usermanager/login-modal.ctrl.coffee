
angular.module('app.usermanager').classy.controller({
	name: 'LoginModalCtrl'
	inject: {
		'$scope' : '$'
		'$modalInstance': '$mi'
	}
	init: ->
		c = @


		c.$.registration = ($event) ->
			if $event
				$event.preventDefault()
				$event.stopPropagation()

			c.$mi.close( {status:'registration' });

})
