// Generated by CoffeeScript 1.8.0
(function() {
  angular.module('jsworkshop').controller('ProfileCtrl', [
    '$scope', '$routeParams', function($scope, $routeParams) {
      $scope.vm = {
        name: 'test'
      };
      $scope.search = function(param) {
        return console.log(param);
      };
      return console.log('profile controller init');
    }
  ]);

}).call(this);
