angular.module("DictionaryGame", [])
.controller("GameCtrl", ($scope) ->
  $scope.socket = io()
  $scope.definitions = []
  $scope.placeholder = "Enter a definition for the word here."
  $scope.voted = -1
  $scope.canVote = true
  $scope.submitButton = "Submit"
  $scope.word = "Anfractuous"
  $scope.showInput = true
  $scope.players = [
    {username: "Vynlar", score: 15},
    {username: "kolyavmk", score: 15},
    {username: "nieodeimus", score: 15}
  ]
  $scope.roomId = $("#roomId").html()

  $scope.socket.emit "join", {roomId: $scope.roomId}

  #when a word update is recieved, update the model
  $scope.socket.on "word", (data) ->
    $scope.word = data.word
    $scope.$apply()

  #when a definition is recieved, update the model
  $scope.socket.on "definition", (data) ->
    console.log data
    $scope.definitions.push data
    $scope.$apply()

  $scope.submitDefinition = () ->
    if $scope.definition?
      $scope.socket.emit "definition", {definition: $scope.definition}
      $scope.showInput = false
  $scope.vote = (index) ->
    if($scope.voted == -1)
      $scope.voted = index
  )
