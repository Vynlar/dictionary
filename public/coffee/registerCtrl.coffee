app = angular.module "RegisterPage", []

app.controller "RegisterController", ["$scope", ($scope) ->
  
  $scope.register = () ->
    $.post "/account", {username:$scope.username,password:$scope.password}, (data) ->
      if data.error?
        console.log data.error
      else if data.message?
        console.log data.message
        window.location.replace "http://" + window.location.host + "/login"
  $scope.update = () ->
    if $scope.password == "" and $scope.passwordConfirm == ""
      $scope.confirmStyle = ""
    else if $scope.password == $scope.passwordConfirm
      $scope.confirmStyle = "green"
    else
      $scope.confirmStyle = "red"
]
