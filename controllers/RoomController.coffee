Room = require("../models/Models").room

module.exports = {
  create: (req, res) ->
    Room.create {},  (err, room) ->
      if err? or !room?
        console.log err
        res.send "An error occourred when creating the room."
      else
        res.redirect "/room/" + room._id
  read: (req, res) ->
    Room.findOne({_id: req.params.id}).exec (err, room) ->
      if(err)
        res.send(404);
      else
        res.render "game", {roomId: room._id}
}
