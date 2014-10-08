angular.module('jsworkshop').controller( 'ProfileCtrl', [
	'$scope'
	'$routeParams'
	'ProfileService'
	( $scope, $routeParams, profileService ) ->

		$scope.data =
			maxitems: [ {key:'10', value:'10 results'}, {key:'50', value:'50 results'}, {key:'all', value:'All'} ]
			sort: [ {key:'name', value:'Name'}, {key:'surname', value:'Surname'}, {key:'email', value:'Email'} ]
			results : {}

		$scope.searchdata =
			q : undefined
			m : undefined
			s : undefined

		#console.log $scope.data.maxitems

		$scope.search = ( ) ->
			console.log $scope.searchdata

			profileService.search( $scope.searchdata ).then(
				( data ) ->
					console.log data
					$scope.data.results = data
			)

		console.log 'profile controller init'
])
