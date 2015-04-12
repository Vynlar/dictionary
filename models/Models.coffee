mongoose = require "mongoose"

mongoose.connect "mongodb://localhost:27017/dictionary"

account = mongoose.schema {
  username: String,
  password: String,
  email: String
}

room = mongoose.schema {
  status: String,
  players: [account]
}

module.exports = {
  account: mongoose.model "Account", account
  room: mongoose.model "Room", {}
}
