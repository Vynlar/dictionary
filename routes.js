(function() {
  var accountController;

  accountController = require("./controllers/AccountController");

  module.exports = function(app) {
    app.post("/account/create", accountController.create);
    return app.get("/account/:username", accountController.read);
  };

}).call(this);
