accountController = require("./controllers/AccountController")
roomController = require("./controllers/RoomController")
module.exports = (app) ->

  #account routes
  app.post "/account/create", accountController.create
  app.get "/account/:username", accountController.read

  #room routes
  app.get "/room/create", roomController.create
  app.get "/room/:id", roomController.read
  app.post "/room/:id", roomController.join

  #auth routes

  #index route
  app.get "/", (req, res) ->
    res.render "index"
