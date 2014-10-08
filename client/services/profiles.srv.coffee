angular.module('jsworkshop').service( 'ProfileService', [
	'$q'
	'$http'
	( $q, $http, $translate, restangular ) ->

		@search = ( searchs )->
			#console.log "ProfileService searching..." + JSON.stringify( searchs )
			deferred = $q.defer()

			q = if searchs.q then searchs.q else ''
			m = if searchs.m?.key? then searchs.m.key else ''
			p = if searchs.p?.key? then searchs.p.key else ''

			console.log('q: ' + q)
			console.log('m: ' + m)
			console.log('p: ' + p)

			$http
				url: "/api/users?" + "q=" + q + "&m=" + m  + "&p=" + p
				method: "get"
				headers:
					'Accept': "application/json"
					'Content-Type': "application/json;charset=UTF-8"

			.success ( data, status, headers, config) ->
				deferred.resolve( data )

			.error ( err, status, headers, config) ->
				deferred.reject( err );

			return deferred.promise
		return
])
