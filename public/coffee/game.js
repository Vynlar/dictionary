// Generated by CoffeeScript 1.9.1
(function() {
  angular.module("DictionaryGame", []).controller("GameCtrl", function($scope) {
    $scope.socket = io();
    $scope.definitions = ["Severely fractured mine-shaft wall", "Prone to hemorrhoids"];
    $scope.placeholder = "Enter a definition for the word here.";
    $scope.voted = -1;
    $scope.canVote = true;
    $scope.submitButton = "Submit";
    $scope.word = "Anfractuous";
    $scope.showInput = true;
    $scope.players = [
      {
        username: "Vynlar",
        score: 15
      }, {
        username: "kolyavmk",
        score: 15
      }, {
        username: "nieodeimus",
        score: 15
      }
    ];
    $scope.roomId = $("#roomId").html();
    $scope.socket.emit("join", {
      roomId: $scope.roomId
    });
    $scope.socket.on("word", function(data) {
      $scope.word = data.word;
      return $scope.$apply();
    });
    $scope.socket.on("definition", function(data) {
      return $scope.definitions.push(data);
    });
    $scope.submitDefinition = function() {
      if ($scope.definition != null) {
        $scope.definitions.unshift($scope.definition);
        return $scope.showInput = false;
      }
    };
    return $scope.vote = function(index) {
      if ($scope.voted === -1) {
        return $scope.voted = index;
      }
    };
  });

}).call(this);
