// Generated by CoffeeScript 1.8.0
(function() {
  var Account, Room;

  Room = require("../models/Models").room;

  Account = require("../models/Models").accoun;

  module.exports = {
    join: function(req, res) {
      return Room.findOne({
        _id: req.body.roomId
      }).exec(function(err, room) {
        if (err) {
          return res.json({
            error: err
          });
        } else {
          return res.json(room);
        }
      });
    }
  };

}).call(this);
