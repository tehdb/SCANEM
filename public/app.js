angular.module('app', ['ngRoute', 'app.usermanager', 'classy', 'restangular', 'ui.bootstrap', 'ui.select']).constant('routes', [
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
  '$routeProvider', '$locationProvider', 'RestangularProvider', 'routes', 'uiSelectConfig', function($rp, $lp, rp, routes, usc) {
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
  }
]);
;angular.module('app.usermanager', ['classy']);
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
;angular.module('app.usermanager').classy.controller({
  name: 'LoginModalCtrl',
  inject: {
    '$scope': '$',
    '$modalInstance': '$mi'
  },
  init: function() {
    var c;
    c = this;
    return c.$.registration = function($event) {
      if ($event) {
        $event.preventDefault();
        $event.stopPropagation();
      }
      return c.$mi.close({
        status: 'registration'
      });
    };
  }
});
;angular.module('app.usermanager').classy.controller({
  name: 'RegistrationModalCtrl',
  inject: {
    '$scope': '$'
  },
  init: function() {
    var c;
    return c = this;
  }
});
;angular.module('app.usermanager').directive('signupBar', [
  '$modal', function($modal) {
    return {
      restrict: 'AE',
      replace: true,
/* Begin: .temp/client/usermanager/signup-bar */
      template: '<div class="signup"><div ng-click="vm.openRegistrationModal($event)" class="btn btn-link">create accout</div><div ng-click="vm.openLoginModal($event)" class="btn btn-default">sign up</div><div ng-show="false"><ui-select ng-model="person.selected"><ui-select-match placeholder="Select...">{{$select.selected.name}}</ui-select-match><ui-select-choices repeat="p in people | filter: $select.search"><div ng-bind="p.name"></div></ui-select-choices></ui-select></div></div>',/* End: .temp/client/usermanager/signup-bar */
      scope: {},
      controller: angular.module('app.usermanager').classy.controller({
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
                templateUrl: '/partials/usermanager/login-modal.html'
              }).result.then(function(data) {
                if (data.status === 'registration') {
                  return c.$.vm.openRegistrationModal();
                }
              });
            },
            openRegistrationModal: function($event) {
              if ($event == null) {
                $event = null;
              }
              if ($event) {
                $event.preventDefault();
                $event.stopPropagation();
              }
              return $modal.open({
                controller: 'RegistrationModalCtrl',
                templateUrl: '/partials/usermanager/registration-modal.html'
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
