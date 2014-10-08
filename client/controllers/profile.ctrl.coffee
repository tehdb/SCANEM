angular.module('jsworkshop').controller( 'ProfileCtrl', [
	'$scope'
	'$routeParams'
	'ProfileService'
	( $scope, $routeParams, profileService ) ->

		$scope.data =
			searchparam : 'test'
			maxitems: [10, 50, 'all']
			sort: ['name', 'surname', 'email']
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
