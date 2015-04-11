accountController = require("./controllers/AccountController")
module.exports = (app) ->
  app.post "/account/create", accountController.create
  app.get "/account/:username", accountController.read
