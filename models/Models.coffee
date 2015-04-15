mongoose = require "mongoose"

mongoose.connect "mongodb://localhost:27017/dictionary"

account = mongoose.Schema {
  username: {type: String},
  password: String,
  email: String
}

room = mongoose.Schema {
  word: {type: String, default: "Default"},
  definitions: [mongoose.Schema {definition: String, playerId: String}]
  status: {type: String, enum: ["readying", "playing"], default: "readying"},
  players: [account]
}

module.exports = {
  account: mongoose.model "Account", account
  room: mongoose.model "Room", room
}
