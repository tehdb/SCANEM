angular.module('app', ['ngRoute', 'app.usermanager', 'classy', 'restangular']).constant('routes', [
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
  '$routeProvider', '$locationProvider', 'RestangularProvider', 'routes', function($rp, $lp, rp, routes) {
    routes.forEach(function(r) {
      return $rp.when(r.url, r.config);
    });
    $rp.otherwise({
      redirectTo: '/'
    });
    $lp.html5Mode(true);
    $lp.hashPrefix('!');
    rp.setBaseUrl('/api');
  }
]);
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
;
;angular.module('app.usermanager', []).directive('signup', [
  function($modal) {
    return {
      restrict: 'AE',
      replace: true,
/* Begin: .temp/client/usermanager/signup */
      template: '<div class="signup"><p>please signup</p></div>',/* End: .temp/client/usermanager/signup */
      link: function($scope, element, attrs, ctrl) {
        return console.log("signup direcitve");
      }
    };
  }
]);
