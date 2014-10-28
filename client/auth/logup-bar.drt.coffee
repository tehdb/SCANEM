angular
	.module('app.auth')
	.directive( 'logupBar', [
		'$modal'
		($modal) ->
			restrict: 'AE'
			replace: true
			template: '"[[auth/logup-bar]]"'
			scope: {}
			controller: angular.module('app.auth').classy.controller({
				inject:
					'$scope' : '$'
					'AuthSrvc' : 'as'
				init: ->
					c = @

					c.$.vm =
						user: c.as.getUser()
						openLoginModal: ($event=null) ->
							if $event
								$event.preventDefault()
								$event.stopPropagation()

							$modal.open({
								controller: 'LoginModalCtrl'
								templateUrl: '/partials/auth/login-modal.html'

							}).result.then (data) ->

								switch data.status
									when 'signup' then c.$.vm.openSignupModal()
									when 'login' then c.$.vm.user = data.user

						openSignupModal: ($event=null) ->
							if $event
								$event.preventDefault()
								$event.stopPropagation()

							$modal.open({
								controller: 'SignupModalCtrl'
								templateUrl: '/partials/auth/signup-modal.html'
							}).result.then (data) ->
								c.$.vm.openLoginModal() if data.status is 'login'

					c.$.doLogout = ->
						c.as.logout().then(
							(data) -> c.$.vm.user = null
						,
							(err) -> c.$.vm.user = null
						)


			})
			# link : ($scope, element, attrs, ctrl) ->
	])
