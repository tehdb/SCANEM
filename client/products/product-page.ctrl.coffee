
angular.module('app.products').classy.controller({
	name: 'ProductPageCtrl'
	inject: {
		'$scope' : '$'
	}
	init: ->
		c = @


		c.$.vm =
			title : "Sonnenuntergang Am Meer"
			category : "Fensterblick"
			price : 11.77
			rate : 3
			tags : [
				'fensterblick'
				'natur'
				'meer'
				'sonneuntergang'
			]
			selectedSize: '80x60 cm'
			selectedColor: 'weiß'
			sizes : [
				'80x60 cm'
				'100x70 cm'
				'120x80 cm'
				'150x100 cm'
			]






})
