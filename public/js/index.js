(function() {
  angular.module("HomePage", []).controller("HomePageCtrl", [
    "$scope", "$location", function($scope, $location) {
      var names;
      $scope.joined = false;
      $scope.join = function() {
        if ($scope.gameId != null) {
          return $location.path(location.host + "/" + $scope.gameId);
        }
      };
      names = ["George Orwell", "Oscar Wilde", "Aphra Behn", "Dave Chapelle", "Your Mom", "Adrian Aleixandre", "Nick deGarmo", "Kolya Venturi"];
      return $scope.name = names[Math.floor(Math.random() * names.length)];
    }
  ]);

}).call(this);