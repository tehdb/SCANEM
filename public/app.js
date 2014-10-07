angular.module('jsworkshop', ['ngRoute']).config([
  '$routeProvider', '$locationProvider', function($rp, $lp) {
    $rp.otherwise({
      redirectTo: '/index'
    });
  }
]);
;angular.module('jsworkshop').controller('ProfileCtrl', [
  '$scope', '$routeParams', function($scope, $routeParams) {
    $scope.vm = {
      name: 'test test'
    };
    return console.log('profile controller init');
  }
]);
