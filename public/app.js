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
;angular.module('app.usermanager').directive('signupbar', [
  '$modal', function($modal) {
    return {
      restrict: 'AE',
      replace: true,
/* Begin: .temp/client/usermanager/signupbar */
      template: '<div class="signup"><div ng-click="vm.openSignupModal($event)" class="btn btn-default">sign up</div><div ng-show="false"><ui-select ng-model="person.selected"><ui-select-match placeholder="Select...">{{$select.selected.name}}</ui-select-match><ui-select-choices repeat="p in people | filter: $select.search"><div ng-bind="p.name"></div></ui-select-choices></ui-select></div></div>',/* End: .temp/client/usermanager/signupbar */
      scope: {},
      link: function($scope, element, attrs, ctrl) {
        $scope.person = {};
        $scope.vm = {
          openSignupModal: function(event) {
            event.preventDefault();
            event.stopPropagation();
            return $modal.open({
              controller: 'SignupModalCtrl',
              templateUrl: '/partials/usermanager/signupmodal.html'
            });
          }
        };
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
;angular.module('app.usermanager').classy.controller({
  name: 'SignupModalCtrl',
  inject: {
    '$scope': '$'
  },
  init: function() {
    var c;
    return c = this;
  }
});
