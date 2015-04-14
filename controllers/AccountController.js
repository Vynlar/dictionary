(function() {
  var Account, bcrypt;

  Account = require("../models/Models").account;

  bcrypt = require("bcryptjs");

  module.exports = {
    create: function(req, res) {
      return bcrypt.hash(req.body.password, 10, function(err, hash) {
        var account;
        account = new Account({
          username: req.body.username,
          password: hash,
          email: req.body.email
        });
        return account.save(function(err) {
          if (err) {
            return res.json({
              error: "There was an error when creating your account."
            });
          } else {
            return res.json({
              message: "Account successfully created."
            });
          }
        });
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
    "delete": function(req, res) {},
    login: function(req, res) {
      return Account.findOne({
        username: req.body.username
      }).exec(function(err, account) {
        return bcrypt.compare(req.body.password, account.password, function(err, valid) {
          if (valid) {
            req.session.playerId = account._id;
            return res.json({
              message: "Successfully logged in."
            });
          } else {
            req.session.playerId = null;
            return res.json({
              message: "Incorrect username or password"
            });
          }
        });
      });
    }
  };

}).call(this);
