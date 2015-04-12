angular.module("DictionaryGame", [])
.controller("GameCtrl", ($scope) ->
  $scope.definitions = ["Severely fractured mine-shaft wall",
                        "Prone to hemorrhoids"]
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

  $scope.submitDefinition = () ->
    if $scope.definition?
      $scope.definitions.unshift $scope.definition
      $scope.showInput = false
  $scope.vote = (index) ->
    if($scope.voted == -1)
      $scope.voted = index
  )
