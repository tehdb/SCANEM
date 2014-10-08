angular.module('jsworkshop').service( 'ProfileService', [
	'$q'
	'$http'
	( $q, $http, $translate, restangular ) ->

		@search = ( searchs )->
			#console.log "ProfileService searching..." + JSON.stringify( searchs )
			deferred = $q.defer()
			$http
				url: "/api/users"
				method: "get"
				headers:
					'Accept': "application/json"
					'Content-Type': "application/json;charset=UTF-8"
				data : searchs

			.success ( data, status, headers, config) ->
				deferred.resolve( data )

			.error ( err, status, headers, config) ->
				deferred.reject( err );

			return deferred.promise



		return
])
