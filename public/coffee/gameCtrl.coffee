angular.module("DictionaryGame")
.controller "GameCtrl", ["$scope", ($scope) ->
  $scope.socket = io()
  $scope.definitions = []
  $scope.placeholder = "Enter a definition for the word here."
  $scope.voted = -1
  $scope.canVote = true
  $scope.submitButton = "Submit"
  $scope.word = ""
  $scope.showInput = true
  $scope.players = []
  $scope.roomId = $("#roomId").html()

  $scope.socket.emit "join", {roomId: $scope.roomId}

  #when a word update is recieved, update the model
  $scope.socket.on "word", (data) ->
    $scope.word = data.word
    $scope.$apply()

  $scope.socket.on "done", (data) ->
    console.log data

  $scope.socket.on "playerJoin", (data) ->
    $scope.players.push data
    $scope.$apply()

  $scope.socket.on "playerLeave", (data) ->
    for player in $scope.players
      #MAKE THIS USE ID'S
      $scope.players.forEach (player, i) ->
        if player.username == data.username
          $scope.players.splice i, 1
    $scope.$apply()

  $scope.socket.on "message", (data) ->
    if data.error?
      console.log "Error: #{data.error}"
    if data.message?
      console.log "Message: #{data.message}"

  $scope.socket.on "hideInput", (data) ->
    $scope.showInput = false
    $scope.$apply()

  #when a definition is recieved, update the model
  $scope.socket.on "definition", (data) ->
    $scope.definitions.push data
    $scope.$apply()

  $scope.submitDefinition = () ->
    if $scope.definition?
      $scope.socket.emit "definition", {definition: $scope.definition}
      $scope.showInput = false
  $scope.vote = (index) ->
    if($scope.voted == -1)
      $scope.voted = index
]