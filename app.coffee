express = require("express")
bodyParser = require("body-parser")
Session = require("express-session")
Server = require("http").Server
router = require("./routes")
passport = require("passport")
LocalStrategy = require("passport-local").Strategy
Account = require("./models/Models").account

app = express()
server = Server(app)
io = require("socket.io")(server)
session = Session {secret: "lkjmagsmohiuy324fm0p8yuagdshklmc190m82y3cr"}
passport.use(new LocalStrategy (username, password, done) ->
  Account.findOne({username: username}).exec (err, account) ->
    if err
      return done err
    if !user
      return done null, false, {message: "Incorrect username."}
    if !user.validPassword(password)
      return done null, false, {message: "Incorrect username."}
    return done null, user
)

app.use(bodyParser.json())
app.use(session)
app.set 'views', './views'
app.set 'view engine', 'jade'
app.use express.static "public"
app.use passport.initialize()
app.use passport.session()

io.use (socket, next) ->
  session socket.request, socket.request.res, next

router(app, io)

server.listen(3000)
