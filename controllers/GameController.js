(function() {
  var Account, Room;

  Room = require("../models/Models").room;

  Account = require("../models/Models").account;

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
        return Account.findOne({
          _id: _playerId
        }).exec(function(err, account) {
          if ((err == null) && (account != null)) {
            return Room.findOne({
              _id: _roomId
            }).exec(function(err, room) {
              var definition, player, _i, _j, _len, _len1, _ref, _ref1;
              socket.emit("word", {
                word: room.word
              });
              _ref = room.definitions;
              for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                definition = _ref[_i];
                socket.emit("definition", definition);
              }
              _ref1 = room.players;
              for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
                player = _ref1[_j];
                socket.emit("connect", {
                  username: player.username
                });
              }
              return io.to(_roomId).emit("connect", {
                username: account.username
              });
            });
          } else {
            return socket.emit("message", {
              error: "Couldn't find the account '" + _playerId + "'"
            });
          }
        });
      });
      return socket.on("definition", function(data) {
        if ((_playerId != null) && (_roomId != null)) {
          return Room.findOne({
            _id: _roomId
          }).exec(function(err, room) {
            var definition, numConnectedClients;
            if (err || (room == null)) {

            } else {
              definition = {
                definition: data.definition,
                playerId: _playerId
              };
              room.definitions.push(definition);
              room.save();
              io.to(_roomId).emit("definition", definition);
              numConnectedClients = Object.keys(io.nsps["/"].adapter.rooms[_roomId]).length;
              if (room.definitions.length >= numConnectedClients) {
                return io.to(_roomId).emit("done", {
                  message: "All definitions have been submitted"
                });
              }
            }
          });
        }
      });
    });
  };

}).call(this);
