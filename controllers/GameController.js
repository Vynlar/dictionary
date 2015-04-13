(function() {
  var Account, Room;

  Room = require("../models/Models").room;

  Account = require("../models/Models").accoun;

  module.exports = function(io) {
    return io.on("connection", function(socket) {
      var _playerId, _roomId;
      _playerId = null;
      _roomId = null;
      socket.on("join", function(data) {
        if (socket.request.session.playerId != null) {
          _playerId = socket.request.session.playerId;
        }
        if (data.roomId != null) {
          _roomId = data.roomId;
          socket.join(_roomId);
        } else {
          return socket.emit("error", {
            error: "Room ID was not included in the join request."
          });
        }
        return Room.findOne({
          _id: _roomId
        }).exec(function(err, room) {
          var definition, _i, _len, _ref, _results;
          socket.emit("word", {
            word: room.word
          });
          _ref = room.definitions;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            definition = _ref[_i];
            _results.push(socket.emit("definition", definition));
          }
          return _results;
        });
      });
      return socket.on("definition", function(data) {
        if ((_playerId != null) && (_roomId != null)) {
          return Room.findOne({
            _id: _roomId
          }).exec(function(err, room) {
            if (err || (room == null)) {
              return res.json({
                error: "Error finding the room."
              });
            } else {
              room.definitions.push(data.definition);
              return room.save();
            }
          });
        }
      });
    });
  };

}).call(this);
