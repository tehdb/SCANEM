angular.module('jsworkshop').controller( 'ProfileCtrl', [
	'$scope'
	'$routeParams'
	'ProfileService'
	( $scope, $rp, profileService ) ->

		profileService.getProfileByEmail( $rp.email ).then (data) ->
			$scope.profile = data
])
