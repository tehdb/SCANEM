angular
	.module('app.usermanager')
	.directive( 'signupBar', [
		'$modal'
		($modal) ->
			restrict: 'AE'
			replace: true
			template: '"[[usermanager/signup-bar]]"'
			scope: {}
			controller: angular.module('app.usermanager').classy.controller({
				inject:
					'$scope' : '$'
				init: ->
					c = @


					c.$.vm =
						openLoginModal: ($event=null) ->
							if $event
								$event.preventDefault()
								$event.stopPropagation()

							$modal.open({
								controller: 'LoginModalCtrl'
								templateUrl: '/partials/usermanager/login-modal.html'

							}).result.then (data) ->
								c.$.vm.openRegistrationModal() if data.status is 'registration'

						openRegistrationModal: ($event=null) ->
							if $event
								$event.preventDefault()
								$event.stopPropagation()

							$modal.open({
								controller: 'RegistrationModalCtrl'
								templateUrl: '/partials/usermanager/registration-modal.html'

						})
			})
			link : ($scope, element, attrs, ctrl) ->

				$scope.person = {}

				$scope.people = [
					{
						name: 'tehdb'
					},{
						name: 'mursa'
					}
				]
	])
