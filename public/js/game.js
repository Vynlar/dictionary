// Generated by CoffeeScript 1.10.0
(function() {
  angular.module("DictionaryGame", []).controller("GameCtrl", function($scope) {
    $scope.socket = io();
    $scope.definitions = [];
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
    $scope.socket.on("done", function(data) {
      return console.log(data);
    });
    $scope.socket.on("connect", function(data) {
      return $scope.players.push(data);
    });
    $scope.socket.on("voted", function(data) {
      $scope.canVote = false;
      return $scope.voted = data;
    });
    $scope.socket.on("message", function(data) {
      if (data.error != null) {
        console.log("Error: " + data.error);
      }
      if (data.message != null) {
        return console.log("Message: " + data.message);
      }
    });
    $scope.socket.on("definition", function(data) {
      console.log(data);
      $scope.definitions.push(data);
      return $scope.$apply();
    });
    $scope.submitDefinition = function() {
      if ($scope.definition != null) {
        $scope.socket.emit("definition", {
          definition: $scope.definition
        });
        return $scope.showInput = false;
      }
    };
    return $scope.vote = function(index) {
      if ($scope.voted === -1) {
        $scope.voted = index;
        return $scope.socket.emit("vote", $scope.definitions[index].playerId);
      }
    };
  });

}).call(this);
