angular.module('jsworkshop').controller( 'ProfileCtrl', [
	'$scope'
	'$routeParams'
	'ProfileService'
	( $scope, $routeParams, profileService ) ->

		$scope.data =
			maxitems: [ {key:'10', value:'10 results'}, {key:'50', value:'50 results'}, {key:'-1', value:'All'} ]
			properties: [ {key:'name', value:'Name'}, {key:'surname', value:'Surname'}, {key:'email', value:'Email'}, {key:'-1', value:'All entries'}  ]
			results : {}

		$scope.searchdata =
			q : undefined
			m : undefined
			p : undefined

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
