Account = require("../models/Models").account

module.exports = {
    create: (req, res) ->
      account = new Account {username: req.body.username, password: req.body.password, email: req.body.email}
      account.save (err) ->
        if err
          res.json {error: "ERROR"}
        else
          req.session.user = account
          res.json {message: "Success! :D"}
    read: (req, res) ->
      console.log(req.params)
      Account.findOne({username: req.params.username}).exec (err, account) ->
        if err?
          res.json {error: err}
        else if account?
          res.json {email: account.email}
        else
          res.json {error: "Could not find the account."}
    update: (req, res) ->

    delete: (req, res) ->

    login: (req, res) ->
      #define session.playerId
      req.session.playerId = "derps"
      res.json {message: "Logged in."}
}
