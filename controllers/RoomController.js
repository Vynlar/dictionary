(function() {
  var Room;

  Room = require("../models/Models").room;

  module.exports = {
    create: function(req, res) {
      return Room.create({}, function(err, room) {
        if ((err != null) || (room == null)) {
          console.log(err);
          return res.send("An error occourred when creating the room.");
        } else {
          return res.redirect("/room/" + room._id);
        }
      });
    },
    read: function(req, res) {
      return Room.findOne({
        _id: req.params.id
      }).exec(function(err, room) {
        if (err) {
          return res.send(404);
        } else {
          return res.render("game", {
            roomId: room._id
          });
        }
      });
    }
  };

}).call(this);
