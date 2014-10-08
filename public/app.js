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
          value: 'Alle entries'
        }
      ],
      results: {}
    };
    $scope.searchdata = {
      q: void 0,
      m: void 0,
      p: void 0
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
      var deferred, m, p, q, _ref, _ref1;
      deferred = $q.defer();
      q = searchs.q ? searchs.q : '';
      m = ((_ref = searchs.m) != null ? _ref.key : void 0) != null ? searchs.m.key : '';
      p = ((_ref1 = searchs.p) != null ? _ref1.key : void 0) != null ? searchs.p.key : '';
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
  }
]);
