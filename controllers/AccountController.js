(function() {
  var Account;

  Account = require("../models/Account");

  module.exports = {
    create: function(req, res) {
      var account;
      account = new Account({
        username: req.body.username,
        password: req.body.password,
        email: req.body.email
      });
      return account.save(function(err) {
        if (err) {
          return res.json({
            error: "ERROR"
          });
        } else {
          req.session.user = account;
          return res.json({
            message: "Success! :D"
          });
        }
      });
    },
    read: function(req, res) {
      console.log(req.params);
      return Account.findOne({
        username: req.params.username
      }).exec(function(err, account) {
        if (err != null) {
          return res.json({
            error: err
          });
        } else if (account != null) {
          return res.json({
            email: account.email
          });
        } else {
          return res.json({
            error: "Could not find the account."
          });
        }
      });
    },
    update: function(req, res) {},
    "delete": function(req, res) {}
  };

}).call(this);