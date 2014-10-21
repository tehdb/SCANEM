angular
	.module('app.usermanager')
	.directive( 'signupbar', [
		'$modal'
		($modal) ->
			restrict: 'AE'
			replace: true
			template: '"[[usermanager/signupbar]]"'
			scope: {}
			link : ($scope, element, attrs, ctrl) ->

				$scope.person = {}

				$scope.vm =
					openSignupModal: (event) ->
						event.preventDefault()
						event.stopPropagation()

						$modal.open({
							controller: 'SignupModalCtrl'
							templateUrl: '/partials/usermanager/signupmodal.html'

						})

						# console.log "open modal"

				$scope.people = [
					{
						name: 'tehdb'
					},{
						name: 'mursa'
					}
				]
	])
