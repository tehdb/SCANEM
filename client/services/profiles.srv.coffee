angular.module('app').service( 'ProfileService', [
	'Restangular'
	( ra ) ->
		c = @

		c.select = ->
			base = ra.all('api/users')


			base.getList().then (users) ->
				console.log users

		return
])
