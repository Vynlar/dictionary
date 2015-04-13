Room = require("../models/Models").room
Account = require("../models/Models").account

module.exports = (io) ->
  #main socketio connection event
  io.on "connection", (socket) ->
    #session variables (these persist during a socket connection)
    _playerId = null
    _roomId = null

    #------------------------------------------
    #when a client requests to join a room
    #request contains a roomId
    socket.on "join", (data) ->
      #check if the user is authenticated
      if socket.request.session.playerId?
        #if so, save the player id to a variable
        _playerId = socket.request.session.playerId
      #check if the socket event contained the roomId
      if data.roomId?
        _roomId = data.roomId;
        socket.join _roomId
        console.log "'#{_playerId}' has joined the room '#{_roomId}''"
      #otherwise return an error
      else
        return socket.emit "error", {error: "Room ID was not included in the join request."}
      #if the script gets this far, the room and playerids are set and valid
      Room.findOne({_id: _roomId}).exec (err, room) ->
        #
        socket.emit "word", {word: room.word}
        #send all the existing definitions to the client
        for definition in room.definitions
          socket.emit "definition", definition
    #------------------------------------------
    #when a client submits a definition
    #request contains the definition
    socket.on "definition", (data) ->
      #check if the room and player variables are defined
      if _playerId? and _roomId?
        #if so, take the definition and add it to the room
        Room.findOne({_id: _roomId}).exec (err, room) ->
          if err or !room?
            #couldn't find room
          else
            definition = {definition: data.definition, playerId: _playerId}
            room.definitions.push definition
            room.save()
            socket.to(_roomId).emit "definition", definition
            console.log room.definitions
