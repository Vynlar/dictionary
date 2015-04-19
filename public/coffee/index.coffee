angular.module("HomePage", [])
.controller "HomePageCtrl", ["$scope", "$location", ($scope, $location) ->
  $scope.joined = false
  $scope.join = () ->
    if $scope.roomId?
      window.location.replace("http://" + location.host + "/room/" + $scope.roomId)
      #window.location.href.replace("http://google.com")
  names = ["George Orwell",
           "Oscar Wilde",
           "Aphra Behn",
           "Dave Chapelle",
           "Your Mom",
           "Adrian Aleixandre",
           "Nick deGarmo",
           "Nina Bice",
           "Kolya Venturi"]
  $scope.name = names[Math.floor(Math.random() * names.length)]
]
