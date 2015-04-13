accountController = require("./controllers/AccountController")
roomController = require("./controllers/RoomController")
gameController = require("./controllers/GameController")

module.exports = (app, io) ->

  #account routes
  app.post "/account/create", accountController.create
  app.get "/account/:username", accountController.read

  #room/game routes
  app.get "/room/create", roomController.create
  app.get "/room/:id", roomController.read

  #auth routes

  #index route
  app.get "/", (req, res) ->
    res.render "index"
