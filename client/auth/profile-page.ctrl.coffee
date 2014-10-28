
angular.module('app.auth').classy.controller({
	name: 'ProfilePageCtrl'
	inject: {
		'$scope' : '$'
		'user': 'u'
	}
	init: ->
		c = @

		c.$.vm =
			user : c.u

})