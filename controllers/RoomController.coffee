Room = require("../models/Models").room

module.exports = {
  create: (req, res) ->
    Room.create {status: "readying"},  (err, room) ->
      res.redirect "/room/" + room._id
  read: (req, res) ->
    Room.findOne({_id: req.params.id}).exec (err, room) ->
      if(err)
        res.send(404);
      else
        res.render "game", {roomId: room._id}
}
