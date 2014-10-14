angular.module('app', ['ngRoute', 'classy', 'restangular']).config([
  '$routeProvider', '$locationProvider', 'RestangularProvider', function($rp, $lp, rp) {
    $rp.when('/', {
      templateUrl: '/partials/home.html',
      controller: 'HomeCtrl'
    }).when('/user/:email', {
      templateUrl: '/partials/profile.html',
      controller: 'ProfileCtrl'
    }).otherwise({
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
    '$scope': '$',
    '$routeParams': '$rp',
    'Restangular': 'ra'
  },
  init: function() {
    var c;
    c = this;
    c.$.data = {};
    return c.ra.all('users').getList().then(function(users) {
      return c.$.data.results = users;
    });
  }
});
;angular.module('jsworkshop').controller('ProfileCtrl', [
  '$scope', '$routeParams', 'ProfileService', function($scope, $rp, profileService) {
    return profileService.getProfileByEmail($rp.email).then(function(data) {
      return $scope.profile = data;
    });
  }
]);
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
