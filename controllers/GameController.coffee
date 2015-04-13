Room = require("../models/Models").room
Account = require("../models/Models").accoun

module.exports = (io) ->
  io.on "connection", (socket) ->

    var _playerId, _roomId;

    socket.on "join", (data) ->
      if data.roomId? and data.playerId?
        _playerId = data.playerId;
        _roomId = data.roomId;
        socket.join roomId
