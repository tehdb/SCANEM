angular.module('jsworkshop', ['ngRoute', 'breeze.angular']).config([
  '$routeProvider', '$locationProvider', function($rp, $lp) {
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
  }
]);
;angular.module('jsworkshop').controller('HomeCtrl', [
  '$scope', '$routeParams', 'ProfileService', function($scope, $routeParams, profileService) {
    return profileService.select();
  }
]);
;angular.module('jsworkshop').controller('ProfileCtrl', [
  '$scope', '$routeParams', 'ProfileService', function($scope, $rp, profileService) {
    return profileService.getProfileByEmail($rp.email).then(function(data) {
      return $scope.profile = data;
    });
  }
]);
;angular.module('jsworkshop').service('ProfileService', [
  'breeze', function(breeze) {
    var c;
    c = this;
    c.select = function() {
      var manager, query, res;
      manager = new breeze.EntityManager('/api');
      query = new breeze.EntityQuery().from('Users');
      res = manager.executeQuery(query).then(function(data) {
        return console.log(data);
      })["catch"](function(err) {
        return console.log(err);
      });
      return console.log(res);
    };
  }
]);
