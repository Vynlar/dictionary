(function() {
  var accountController, gameController, roomController;

  accountController = require("./controllers/AccountController");

  roomController = require("./controllers/RoomController");

  gameController = require("./controllers/GameController");

  module.exports = function(app, io) {
    app.post("/account/create", accountController.create);
    app.get("/account/:username", accountController.read);
    app.get("/room/create", roomController.create);
    app.get("/room/:id", roomController.read);
    app.get("/", function(req, res) {
      return res.render("index");
    });
    return gameController(io);
  };

}).call(this);
