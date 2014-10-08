angular.module('jsworkshop', ['ngRoute']).config([
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
    $scope.data = {
      maxitems: [
        {
          key: '10',
          value: '10 results'
        }, {
          key: '50',
          value: '50 results'
        }, {
          key: '-1',
          value: 'All'
        }
      ],
      properties: [
        {
          key: 'name',
          value: 'Name'
        }, {
          key: 'surname',
          value: 'Surname'
        }, {
          key: 'email',
          value: 'Email'
        }, {
          key: '-1',
          value: 'All entries'
        }
      ],
      results: {},
      total: 0
    };
    $scope.searchdata = {
      q: void 0,
      m: void 0,
      p: void 0
    };
    return ($scope.search = function() {
      return profileService.search($scope.searchdata).then(function(data) {
        $scope.data.total = data.length;
        return $scope.data.results = data;
      });
    })();
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
  '$q', '$http', function($q, $http, $translate, restangular) {
    this.search = function(searchs) {
      var deferred, m, p, q, _ref, _ref1;
      deferred = $q.defer();
      q = searchs.q ? searchs.q : '';
      m = ((_ref = searchs.m) != null ? _ref.key : void 0) != null ? searchs.m.key : '-1';
      p = ((_ref1 = searchs.p) != null ? _ref1.key : void 0) != null ? searchs.p.key : '-1';
      console.log('q: ' + q);
      console.log('m: ' + m);
      console.log('p: ' + p);
      $http({
        url: "/api/users?" + "q=" + q + "&m=" + m + "&p=" + p,
        method: "get",
        headers: {
          'Accept': "application/json",
          'Content-Type': "application/json;charset=UTF-8"
        }
      }).success(function(data, status, headers, config) {
        return deferred.resolve(data);
      }).error(function(err, status, headers, config) {
        return deferred.reject(err);
      });
      return deferred.promise;
    };
    this.getProfileByEmail = function(email) {
      var deferred;
      deferred = $q.defer();
      $http({
        url: "/api/user/" + email,
        method: "get",
        headers: {
          'Accept': "application/json",
          'Content-Type': "application/json;charset=UTF-8"
        }
      }).success(function(data, status, headers, config) {
        return deferred.resolve(data);
      }).error(function(err, status, headers, config) {
        return deferred.reject(err);
      });
      return deferred.promise;
    };
  }
]);
