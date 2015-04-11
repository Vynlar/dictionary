angular.module("HomePage", [])
.controller("HomePageCtrl", ["$scope", "$location" ,($scope, $location) ->
  $scope.joined = false
  $scope.join = () ->
    #console.log($scope.gameId)
    if $scope.gameId?
      $location.path(location.host + "/" + $scope.gameId)
      #window.location.href.replace("http://google.com")
  names = ["George Orwell",
           "Oscar Wilde",
           "Aphra Behn",
           "Dave Chapelle",
           "Your Mom",
           "Adrian Aleixandre",
           "Nick deGarmo",
           "Kolya Venturi"]
  $scope.name = names[Math.floor(Math.random() * names.length)]
])
