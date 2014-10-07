angular.module('jsworkshop').controller( 'ProfileCtrl', [
	'$scope'
	'$routeParams'
	'ProfileService'
	( $scope, $routeParams, profileService ) ->

		$scope.vm =
			name : 'test test'

		$scope.search = ( param ) ->
			console.log param
			profileService.search(param).then(
					( data ) ->
				)

		console.log 'profile controller init'
])
