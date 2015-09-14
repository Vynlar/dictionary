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
        _roomId = data.roomId
        socket.join _roomId
      #otherwise return an error
      else
        return socket.emit "error", {error: "Room ID was not included in the join request."}
      #if the script gets this far, the room and playerids are set and valid
      Account.findOne({_id: _playerId}).exec (err, account) ->
        if !err? and account?
          Room.findOne({_id: _roomId}).exec (err, room) ->
            #check if the player is still in the room
            for player in room.players
              if player._id.equals account._id
                socket.emit "message", {message: "Account already in room"}
                return
            #send word to the client
            socket.emit "word", {word: room.word}
            #send all the existing definitions to the client
            for definition in room.definitions
              socket.emit "definition", definition
            #tell client all the other connected clients
            for player in room.players
              socket.emit "playerJoin", {username: player.username}
            #tell all other clients that this one connected
            io.to(_roomId).emit "playerJoin", {username: account.username}
            #if they already submitted, hide the submission bar
            for definition in room.definitions
              if _playerId == definition.playerId
                socket.emit "hideInput"
            #add player to room's player list
            room.players.push account
            room.save()
        else
          socket.emit "message", {error: "Couldn't find the account '#{_playerId}'"}
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
            #found the room
            definition = {definition: data.definition, playerId: _playerId}
            #add the definition to the room and publish to the database
            room.definitions.push definition
            room.save()
            #tell all the clients about it
            io.to(_roomId).emit "definition", definition
            #get list of clients in the room
            numConnectedClients = Object.keys(io.nsps["/"].adapter.rooms[_roomId]).length
            #check if the number of definitions is equal to the number of clients
            if room.definitions.length >= numConnectedClients
              io.to(_roomId).emit "done", {message: "All definitions have been submitted"}
    socket.on "disconnect", () ->
      #remove the player from the room on disconnect
      Account.findOne({_id: _playerId}).exec (err, account) ->
        if err? or !account?
          socket.emit "message", {message: "Error finding account when destroying."}
          console.log "Error finding account. There may be duplicates in room #{_roomId}"
        else
          io.to(_roomId).emit "playerLeave", {username: account.username}
      Room.findOne({_id: _roomId}).exec (err, room) ->
        if !err? and room?
          for i in [room.players.length-1..0]
            if room.players[i]._id.equals _playerId
              room.players.splice i, 1
          room.save()
    socket.on "vote", (data) ->
      #when a user sends a vote in
      Room.findOne({_id: _roomId}).exec (err, room) ->
        room.definitions.forEach (entry, id) ->
          if entry.playerId == data.playerId
            entry.votes.push data.playerId
            room.save()
          io.to(_roomId).emit "vote", {playerId: data.playerId}
