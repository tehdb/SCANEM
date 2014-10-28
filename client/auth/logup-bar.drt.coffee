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
					'$location' : '$l'
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
						logoutHanlder = ->
							c.$.vm.user = null
							c.$l.path('/')

						c.as.logout().then( logoutHanlder, logoutHanlder )


			})
			# link : ($scope, element, attrs, ctrl) ->
	])
