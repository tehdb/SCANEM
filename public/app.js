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
      name: 'test',
      results: {}
    };
    $scope.search = function(param) {
      console.log(param);
      return profileService.search(param).then(function(data) {
        console.log(data);
        return $scope.data.results = data;
      });
    };
    return console.log('profile controller init');
  }
]);
;angular.module('jsworkshop').service('ProfileService', [
  '$q', '$http', function($q, $http, $translate, restangular) {
    this.search = function(data) {
      var deferred;
      console.log("ProfileService searching..." + JSON.stringify(data));
      deferred = $q.defer();
      $http({
        url: "/api/users",
        method: "get",
        headers: {
          'Accept': "application/json",
          'Content-Type': "application/json;charset=UTF-8"
        },
        data: data
      }).success(function(data, status, headers, config) {
        return deferred.resolve(data);
      }).error(function(err, status, headers, config) {
        return deferred.reject(err);
      });
      return deferred.promise;
    };
  }
]);
