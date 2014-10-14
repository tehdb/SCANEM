angular.module('jsworkshop').service( 'ProfileService', [
	'breeze'
	( breeze ) ->
		c = @

		c.select = ->
			manager = new breeze.EntityManager('/api')

			query = new breeze.EntityQuery().from('Users')

			res = manager
				.executeQuery(query)
				.then (data) ->
					console.log data
				.catch (err) ->
					console.log err
			console.log res

		return
])
