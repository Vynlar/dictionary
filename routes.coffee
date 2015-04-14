accountController = require("./controllers/AccountController")
roomController = require("./controllers/RoomController")
gameController = require("./controllers/GameController")

module.exports = (app, io) ->

  #account routes
  app.post "/account/create", accountController.create
  app.get "/account/:username", accountController.read
  
  #auth routes
  

  #room/game routes
  app.get "/room/create", roomController.create
  app.get "/room/:id", roomController.read

  #index route
  app.get "/", (req, res) ->
    res.render "index"

  gameController io
