angular.module('app', ['ngRoute', 'ngCookies', 'app.auth', 'classy', 'restangular', 'ui.bootstrap', 'ui.select', 'pascalprecht.translate', 'angular-md5']).constant('routes', [
  {
    url: '/',
    config: {
      title: 'home',
      templateUrl: '/partials/layout/home.html',
      settings: {}
    }
  }, {
    url: '/user/:email',
    config: {
      title: 'user',
      templateUrl: '/partials/profile.html',
      settings: {}
    }
  }
]).config([
  '$routeProvider', '$locationProvider', '$translateProvider', 'RestangularProvider', 'routes', 'uiSelectConfig', function($rp, $lp, $tp, rp, routes, usc) {
    routes.forEach(function(r) {
      return $rp.when(r.url, r.config);
    });
    $rp.otherwise({
      redirectTo: '/'
    });
    $lp.html5Mode(true);
    $lp.hashPrefix('!');
    rp.setBaseUrl('/api');
    usc.theme = 'bootstrap';
    $tp.useUrlLoader('/api/i18n');
    $tp.preferredLanguage('en_GB');
    $tp.fallbackLanguage('en_GB');
    $tp.usePostCompiling(true);
    $tp.useLocalStorage();
  }
]);
;angular.module('app.auth', ['classy']);
;angular.module('app.auth').factory('AuthSrvc', [
  'Restangular', 'md5', function(ra, md5) {
    var base, res;
    base = ra.all('users');
    res = {
      auth: function(userData) {
        userData.password = md5.createHash(userData.password);
        console.log("***********");
        console.log(userData);
        return console.log("***********");
      }
    };
    return res;
  }
]);
;angular.module('app.auth').classy.controller({
  name: 'LoginModalCtrl',
  inject: {
    '$scope': '$',
    '$modalInstance': '$mi',
    'AuthSrvc': 'as'
  },
  init: function() {
    var c;
    c = this;
    c.$.doLogin = function($event) {
      var userData;
      if ($event) {
        $event.preventDefault();
        $event.stopPropagation();
      }
      userData = _.pick(c.$.login, 'username', 'password');
      return c.as.auth(userData);
    };
    return c.$.doSignup = function($event) {
      if ($event) {
        $event.preventDefault();
        $event.stopPropagation();
      }
      return c.$mi.close({
        status: 'signup'
      });
    };
  }
});
;angular.module('app.auth').directive('logupBar', [
  '$modal', function($modal) {
    return {
      restrict: 'AE',
      replace: true,
/* Begin: .temp/client/auth/logup-bar */
      template: '<div class="signup"><div ng-click="vm.openSignupModal($event)" class="btn btn-link">{{"auth.sign_up" | translate }}</div><div ng-click="vm.openLoginModal($event)" class="btn btn-default">{{"auth.log_in" | translate }}</div><div ng-show="false"><ui-select ng-model="person.selected"><ui-select-match placeholder="Select...">{{$select.selected.name}}</ui-select-match><ui-select-choices repeat="p in people | filter: $select.search"><div ng-bind="p.name"></div></ui-select-choices></ui-select></div></div>',/* End: .temp/client/auth/logup-bar */
      scope: {},
      controller: angular.module('app.auth').classy.controller({
        inject: {
          '$scope': '$'
        },
        init: function() {
          var c;
          c = this;
          return c.$.vm = {
            openLoginModal: function($event) {
              if ($event == null) {
                $event = null;
              }
              if ($event) {
                $event.preventDefault();
                $event.stopPropagation();
              }
              return $modal.open({
                controller: 'LoginModalCtrl',
                templateUrl: '/partials/auth/login-modal.html'
              }).result.then(function(data) {
                if (data.status === 'signup') {
                  return c.$.vm.openSignupModal();
                }
              });
            },
            openSignupModal: function($event) {
              if ($event == null) {
                $event = null;
              }
              if ($event) {
                $event.preventDefault();
                $event.stopPropagation();
              }
              return $modal.open({
                controller: 'SignupModalCtrl',
                templateUrl: '/partials/auth/signup-modal.html'
              }).result.then(function(data) {
                if (data.status === 'login') {
                  return c.$.vm.openLoginModal();
                }
              });
            }
          };
        }
      }),
      link: function($scope, element, attrs, ctrl) {
        $scope.person = {};
        return $scope.people = [
          {
            name: 'tehdb'
          }, {
            name: 'mursa'
          }
        ];
      }
    };
  }
]);
;angular.module('app.auth').classy.controller({
  name: 'SignupModalCtrl',
  inject: {
    '$scope': '$',
    '$modalInstance': '$mi'
  },
  init: function() {
    var c;
    c = this;
    return c.$.login = function($event) {
      if ($event) {
        $event.preventDefault();
        $event.stopPropagation();
      }
      return c.$mi.close({
        status: 'login'
      });
    };
  }
});
;angular.module('app').classy.controller({
  name: 'HomeCtrl',
  inject: {
    '$scope': '$'
  },
  init: function() {
    var c, vm;
    c = this;
    c.$.vm = {};
    vm = c.$.vm;
    return vm.title = 'home ctrl';
  }
});
;angular.module('app').service('ProfileService', [
  'Restangular', function(ra) {
    var c;
    c = this;
    c.select = function() {
      var base;
      base = ra.all('api/users');
      return base.getList().then(function(users) {
        return console.log(users);
      });
    };
  }
]);
