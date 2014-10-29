angular
	.module('app.header')
	.directive( 'smHeader', [
		() ->
			restrict: 'AE'
			replace: true
			template: '"[[header/header]]"'
			scope: {}
			controller: angular.module('app.header').classy.controller({
				inject:
					'$scope' : '$'
				init: ->
					c = @

					c.$.vm =
						mainNavbarCollapsed : true
			})
	])