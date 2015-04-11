mongoose = require "mongoose"

mongoose.connect "mongodb://localhost:27017/dictionary"

module.exports = mongoose.model "Account", {username: String, password: String, email: String}
