
angular.module('app.products').classy.controller({
	name: 'ProductPageCtrl'
	inject: {
		'$scope' : '$'
	}
	init: ->
		c = @


		c.$.vm =
			title : "Product title"
			price : 11.77
			rate : 3
			tags : [
				'fensterblick'
				'natur'
				'meer'
				'sonneuntergang'
			]


})
