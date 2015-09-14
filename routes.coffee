accountController = require("./controllers/AccountController")
roomController = require("./controllers/RoomController")
gameController = require("./controllers/GameController")

module.exports = (app, io) ->

  #account routes
  app.post "/account", accountController.create
  app.get "/account/:username", accountController.read
  app.post "/account/login", accountController.login

  app.get "/login", (req, res) ->
    res.render "login"

  app.get "/register", (req, res) ->
    res.render "register"

  app.get "/logout", (req, res) ->
    req.session.playerId = null
    res.send "Good job"
  
  #room/game routes
  app.get "/room/create", roomController.create
  app.get "/room/:id", roomController.read
  gameController io

  #index route
  app.get "/", (req, res) ->
    res.render "index"
