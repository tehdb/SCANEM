angular.module('jsworkshop').service( 'ProfileService', [
	'$q'
	'$http'
	( $q, $http, $translate, restangular ) ->

		@search = ( data )->
			console.log "ProfileService searching..." + JSON.stringify( data )
			deferred = $q.defer()
			$http
				url: "/api/users"
				method: "post"
				headers:
					'Accept': "application/json"
					'Content-Type': "application/json;charset=UTF-8"
				data : data

			.success ( data, status, headers, config) ->
				deferred.resolve( data )

			.error ( err, status, headers, config) ->
				if typeof err.error is 'object' and err.error.code is 11000
					return deferred.reject( label )

				deferred.reject( label );

			return deferred.promise
		return
])