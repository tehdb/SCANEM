angular.module('jsworkshop').service( 'ProfileService', [
	'$q'
	'$http'
	( $q, $http ) ->

		@search = ( searchParams )->
			deferred = $q.defer()

			q = if searchParams.q then searchParams.q else ''
			m = if searchParams.m?.key? then searchParams.m.key else '-1'
			p = if searchParams.p?.key? then searchParams.p.key else '-1'

			console.log('q: ' + q)
			console.log('m: ' + m)
			console.log('p: ' + p)

			$http
				url: "/api/users?q=#{q}&m=#{m}&p=#{p}"
				method: "get"
				headers:
					'Accept': 'application/json'
					'Content-Type': 'application/json;charset=UTF-8'

			.success ( data, status, headers, config) ->
				deferred.resolve( data )

			.error ( err, status, headers, config) ->
				deferred.reject( err );

			return deferred.promise


		@getProfileByEmail = (email) ->
			deferred = $q.defer()

			$http
				url: "/api/user/#{email}"
				method: "get"
				headers:
					'Accept': 'application/json'
					'Content-Type': 'application/json;charset=UTF-8'

			.success ( data, status, headers, config) ->
				deferred.resolve( data )

			.error ( err, status, headers, config) ->
				deferred.reject( err );

			return deferred.promise
		return
])
