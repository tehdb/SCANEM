angular.module('jsworkshop').controller( 'ProfileCtrl', [
	'$scope'
	'$routeParams'
	'ProfileService'
	( $scope, $routeParams, profileService ) ->

		$scope.vm =
			name : 'test'
			results : ['']

		$scope.search = ( param ) ->
			console.log param
			profileService.search( param ).then(
				( data ) ->
					console.log data
					$scope.wm.results = JSON.stringify(data)
			)

		console.log 'profile controller init'
])
