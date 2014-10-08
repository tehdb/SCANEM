angular.module('jsworkshop').controller( 'ProfileCtrl', [
	'$scope'
	'$routeParams'
	'ProfileService'
	( $scope, $routeParams, profileService ) ->

		$scope.data =
			name : 'test'
			results : {}


		$scope.search = ( param ) ->
			console.log param
			profileService.search( param ).then(
				( data ) ->
					console.log data
					$scope.data.results = data
			)

		console.log 'profile controller init'
])
