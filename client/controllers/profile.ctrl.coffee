angular.module('jsworkshop').controller( 'ProfileCtrl', [
	'$scope'
	'$routeParams'
	( $scope, $routeParams ) ->

		$scope.vm =
			name : 'test'

		$scope.search = ( param ) ->
			console.log param

		console.log 'profile controller init'
])