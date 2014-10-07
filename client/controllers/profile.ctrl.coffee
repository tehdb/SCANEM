angular.module('jsworkshop').controller( 'ProfileCtrl', [
	'$scope'
	'$routeParams'
	( $scope, $routeParams ) ->

		$scope.vm =
			name : 'test test'

		console.log 'profile controller init'
])
