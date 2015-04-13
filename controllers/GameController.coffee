Room = require("../models/Models").room
Account = require("../models/Models").accoun

module.exports = (io) ->
  #main socketio connection event
  io.on "connection", (socket) ->
    #session variables (these persist during a socket connection)
    _playerId
    _roomId

    #------------------------------------------
    #when a client requests to join a room
    #request contains a roomId
    socket.on "join", (data) ->
      #check if the user is authenticated
      if !socket.request.session.playerId?
        return res.redirect "/login"
        #otherwise save their playerId to the session variable
      else
        _playerId = socket.request.session.playerId
      #check if the socket event contained the roomId
      if data.roomId?
        _roomId = data.roomId;
        socket.join roomId
      #otherwise return an error
      else
        return socket.emit "error", {error: "Room ID was not included in the join request."}
      #if the script gets this far, the room and playerids are set and valid
      Room.findOne(){_id: _roomId}).exec (err, room) ->
        #
        socket.emit "word", {word: room.word}
        #send all the existing definitions to the client
        for definition in room.definitions
          socket.emit "definition", definition
    #------------------------------------------
