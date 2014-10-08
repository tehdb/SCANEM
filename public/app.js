angular.module('jsworkshop', ['ngRoute']).config([
  '$routeProvider', '$locationProvider', function($rp, $lp) {
    $rp.otherwise({
      redirectTo: '/'
    });
  }
]);
;angular.module('jsworkshop').controller('ProfileCtrl', [
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
          key: 'all',
          value: 'All'
        }
      ],
      sort: [
        {
          key: 'name',
          value: 'Name'
        }, {
          key: 'surname',
          value: 'Surname'
        }, {
          key: 'email',
          value: 'Email'
        }
      ],
      results: {}
    };
    $scope.searchdata = {
      q: void 0,
      m: void 0,
      s: void 0
    };
    $scope.search = function() {
      console.log($scope.searchdata);
      return profileService.search($scope.searchdata).then(function(data) {
        console.log(data);
        return $scope.data.results = data;
      });
    };
    return console.log('profile controller init');
  }
]);
;angular.module('jsworkshop').service('ProfileService', [
  '$q', '$http', function($q, $http, $translate, restangular) {
    this.search = function(searchs) {
      var deferred;
      deferred = $q.defer();
      $http({
        url: "/api/users",
        method: "get",
        headers: {
          'Accept': "application/json",
          'Content-Type': "application/json;charset=UTF-8"
        },
        data: searchs
      }).success(function(data, status, headers, config) {
        return deferred.resolve(data);
      }).error(function(err, status, headers, config) {
        return deferred.reject(err);
      });
      return deferred.promise;
    };
  }
]);
