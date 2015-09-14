Account = require("../models/Models").account
bcrypt = require("bcryptjs")

module.exports = {
    create: (req, res) ->
      bcrypt.hash req.body.password, 10, (err, hash) ->
        account = new Account {username: req.body.username, password: hash, email: req.body.email}
        account.save (err) ->
          if err
            res.json {error: "There was an error when creating your account."}
          else
            res.json {message: "Account successfully created."}
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
      console.log req.body.username
      Account.findOne({username: req.body.username}).exec (err, account) ->
        console.log "AccountController: login(): " + account
        if err? or !account?
          return res.json {message: "Incorrect username or password."}
        bcrypt.compare req.body.password, account.password, (err, valid) ->
          if valid
            req.session.playerId = account._id
            res.json {success: true}
          else
            req.session.playerId = null
            res.json {success: false}
}
