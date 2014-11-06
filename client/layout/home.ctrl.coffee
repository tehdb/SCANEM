
angular.module('app').classy.controller({
	name: 'HomeCtrl',
	inject: {
		'$scope' : '$'
	}
	init: ->
		c = @

		c.$.vm = {}
		vm = c.$.vm

		vm.title = 'home ctrl'


});