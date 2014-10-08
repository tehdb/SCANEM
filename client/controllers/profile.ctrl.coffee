angular.module('jsworkshop').controller( 'ProfileCtrl', [
	'$scope'
	'$routeParams'
	'ProfileService'
	( $scope, $routeParams, profileService ) ->

		$scope.data =
			searchparam : 'test'
			results : {}


		$scope.search = ( searchparam ) ->
			console.log searchparam
			profileService.search( searchparam ).then(
				( data ) ->
					console.log data
					$scope.data.results = data
			)

		console.log 'profile controller init'
])
