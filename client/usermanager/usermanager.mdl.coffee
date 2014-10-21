angular
	.module('app.usermanager', [])


	.directive( 'signup', [

		($modal) ->
			restrict: 'AE'
			replace: true
			template: '"[[usermanager/signup]]"'

			link : ($scope, element, attrs, ctrl) ->
				console.log "signup direcitve"
	])