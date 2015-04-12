// Generated by CoffeeScript 1.8.0
(function() {
  var account, mongoose, room;

  mongoose = require("mongoose");

  mongoose.connect("mongodb://localhost:27017/dictionary");

  account = mongoose.Schema({
    username: String,
    password: String,
    email: String
  });

  room = mongoose.Schema({
    status: {
      type: String,
      "enum": ["readying", "playing"],
      "default": "readying"
    },
    players: [account]
  });

  module.exports = {
    account: mongoose.model("Account", account),
    room: mongoose.model("Room", room)
  };

}).call(this);
