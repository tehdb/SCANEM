angular.module('app', ['ngRoute', 'ngCookies', 'app.auth', 'classy', 'restangular', 'ui.bootstrap', 'ui.select', 'pascalprecht.translate', 'angular-md5']).constant('routes', [
  {
    url: '/',
    config: {
      title: 'home',
      templateUrl: '/partials/layout/home.html',
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
    rp.setBaseUrl('http://localhost:3030/api');
    usc.theme = 'bootstrap';
    $tp.useUrlLoader('/api/i18n');
    $tp.preferredLanguage('en_GB');
    $tp.fallbackLanguage('en_GB');
    $tp.usePostCompiling(true);
    $tp.useLocalStorage();
  }
]).classy.controller({
  name: 'AppCtrl',
  inject: {
    '$rootScope': '$rs',
    '$location': '$l'
  },
  init: function() {
    var c;
    c = this;
    return c.$rs.$on("$routeChangeError", function(event, current, previous, rejection) {
      return c.$l.path('/');
    });
  }
});
;angular.module('app.auth', ['ngRoute', 'classy']).config([
  '$routeProvider', function($rp) {
    return $rp.when('/verify/:token?', {
      controller: 'VerifyPageCtrl',
      templateUrl: '/partials/auth/verify-page.html',
      resolve: {
        user: [
          '$route', 'AuthSrvc', function($r, as) {
            return as.verify($r.current.params.token);
          }
        ]
      }
    });
  }
]);
;angular.module('app.auth').factory('AuthSrvc', [
  'Restangular', 'md5', function(ra, md5) {
    var res;
    res = {
      login: function(userData) {
        var base;
        base = ra.all('user/login');
        userData.password = md5.createHash(userData.password);
        return base.post(userData);
      },
      signup: function(userData) {
        var base;
        base = ra.all('user/signup');
        userData.password = md5.createHash(userData.password);
        return base.post(userData);
      },
      verify: function(token) {
        var base;
        base = ra.all('user/verify');
        return base.post({
          token: token
        });
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
      if ($event) {
        $event.preventDefault();
        $event.stopPropagation();
      }
      return c.as.login(c.$.login).then(function(user) {
        return c.$mi.close({
          status: 'login',
          user: user
        });
      }, function(err) {
        return console.log(err);
      });
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
      template: '<div class="signup"><div ng-hide="vm.user"><div ng-click="vm.openSignupModal($event)" class="btn btn-link">{{"auth.sign_up" | translate }}</div><div ng-click="vm.openLoginModal($event)" class="btn btn-default">{{"auth.log_in" | translate }}</div></div><div ng-show="vm.user"><span>{{vm.user.username}}</span></div><div ng-show="false"><ui-select ng-model="person.selected"><ui-select-match placeholder="Select...">{{$select.selected.name}}</ui-select-match><ui-select-choices repeat="p in people | filter: $select.search"><div ng-bind="p.name"></div></ui-select-choices></ui-select></div></div>',/* End: .temp/client/auth/logup-bar */
      scope: {},
      controller: angular.module('app.auth').classy.controller({
        inject: {
          '$scope': '$'
        },
        init: function() {
          var c;
          c = this;
          return c.$.vm = {
            user: null,
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
                switch (data.status) {
                  case 'signup':
                    return c.$.vm.openSignupModal();
                  case 'login':
                    return c.$.vm.user = data.user;
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
    '$modalInstance': '$mi',
    'AuthSrvc': 'as'
  },
  init: function() {
    var c;
    c = this;
    c.$.doSignup = function($event) {
      if ($event) {
        $event.preventDefault();
        $event.stopPropagation();
      }
      return c.as.signup(c.$.signup).then(function(data) {
        return console.log(data);
      }, function(err) {
        return console.log(err);
      });
    };
    return c.$.doLogin = function($event) {
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
;angular.module('app.auth').classy.controller({
  name: 'VerifyPageCtrl',
  inject: {
    '$scope': '$',
    'user': 'u'
  },
  init: function() {
    var c;
    c = this;
    console.log(c.u);
    return c.$.vm = {
      email: c.u.email
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
