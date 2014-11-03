
angular.module('app.auth').classy.controller({
	name: 'VerifyPageCtrl'
	inject: {
		'$scope' : '$'
		'user': 'u'
	}
	init: ->
		c = @

		# console.log c.u

		c.$.vm =
			email: c.u.email


})