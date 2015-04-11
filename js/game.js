(function() {
  angular.module("DictionaryGame", []).controller("GameCtrl", function($scope) {
    $scope.definitions = ["Severely fractured mine-shaft wall"];
    $scope.placeholder = "Enter a definition for the word here.";
    $scope.voted = -1;
    $scope.canVote = true;
    $scope.submitButton = "Submit";
    $scope.word = "Anfractuous";
    $scope.showInput = true;
    $scope.submitDefinition = function() {
      if ($scope.definition != null) {
        $scope.definitions.unshift($scope.definition);
        return $scope.showInput = false;
      }
    };
    return $scope.vote = function(index) {
      if ($scope.voted === -1) {
        $scope.definitions[index] = "hdhhsdhf";
        return $scope.voted = index;
      }
    };
  });

}).call(this);
