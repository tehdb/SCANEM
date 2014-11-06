
angular.module('app.store').classy.controller({
	name: 'ListViewCtrl'
	inject: {
		'$scope' : '$'
	}
	init: ->
		c = @

		console.log "live view ctrl"

		c.$.vm =
			filter:
				prise: null
			rows: [
				[
					{
						title: 'Lorem ipsum dolor sit amet.'
						price: 111.77
						rating: 1
						image : '/images/AA0197-1.jpg'
					}, {
						title: 'Lorem ipsum dolor sit amet, consectetur adipisicing.'
						price: 111.77
						rating: 2
						image : '/images/AA0197-2.jpg'
					}, {
						title: 'Lorem ipsum.'
						price: 111.77
						rating: 3
						image : '/images/AA0197-3.jpg'
					}, {
						title: 'Lorem ipsum dolor sit amet.'
						price: 111.77
						rating: 4
						image : '/images/AA0197-4.jpg'
					}
				],[
					{
						title: 'Lorem ipsum dolor.'
						price: 111.77
						rating: 5
						image : '/images/AA0197-1.jpg'
					}, {
						title: 'Lorem ipsum dolor sit amet, consectetur.'
						price: 111.77
						rating: 3.5
						image : '/images/AA0197-2.jpg'
					}, {
						title: 'Lorem ipsum dolor sit amet, consectetur adipisicing.'
						price: 111.77
						rating: 4.1
						image : '/images/AA0197-3.jpg'
					}
				]
			]

			products: [

			]

})
