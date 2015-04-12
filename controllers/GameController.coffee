Room = require("../models/Models").room
Account = require("../models/Models").accoun

module.exports = {
  join: (req, res) ->
    Room.findOne({_id: req.body.roomId}).exec (err, room) ->
      if(err)
        res.json {error: err}
      else
        res.json room
}
