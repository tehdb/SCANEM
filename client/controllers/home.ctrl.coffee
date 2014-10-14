
angular.module('app').classy.controller({
	name: 'HomeCtrl',
	inject: {
		'$scope' : '$'
		'$routeParams' : '$rp'
		'Restangular' : 'ra'
	}
	init: ->
		c = @

		c.$.data = {}
		c.ra.all('users').getList().then (users) ->
			c.$.data.results = users

});
