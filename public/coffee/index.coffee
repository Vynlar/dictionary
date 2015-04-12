angular.module("HomePage", [])
.controller "HomePageCtrl", ["$scope", "$location", ($scope, $location) ->
  $scope.joined = false
  $scope.join = () ->
    if $scope.roomId?
      $location.path(location.host + "/room/" + $scope.roomId)
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
]
