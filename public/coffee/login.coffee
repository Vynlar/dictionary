module = angular.module "LoginPage", []

module.controller "LoginController", ["$scope", ($scope) ->
  $scope.login = () ->
    $.post "/account/login", {username: $scope.username, password: $scope.password}, (data) ->
      if data.success
        console.log window.location.host
        window.location.replace "http://" + window.location.host
]
