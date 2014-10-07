angular.module('jsworkshop', ['ngRoute']).config([
  '$routeProvider', '$locationProvider', function($rp, $lp) {
    $rp.otherwise({
      redirectTo: '/'
    });
  }
]);
;angular.module('jsworkshop').controller('ProfileCtrl', [
  '$scope', '$routeParams', function($scope, $routeParams) {
    $scope.vm = {
      name: 'test test'
    };
    $scope.search = function(param) {
      return console.log(param);
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
        method: "post",
        headers: {
          'Accept': "application/json",
          'Content-Type': "application/json;charset=UTF-8"
        },
        data: data
      }).success(function(data, status, headers, config) {
        return deferred.resolve(data);
      }).error(function(err, status, headers, config) {
        if (typeof err.error === 'object' && err.error.code === 11000) {
          return deferred.reject(label);
        }
        return deferred.reject(label);
      });
      return deferred.promise;
    };
  }
]);
