express = require("express")
bodyParser = require("body-parser")
Session = require("express-session")
Server = require("http").Server
router = require("./routes")
Account = require("./models/Models").account

app = express()
server = Server(app)
io = require("socket.io")(server)
session = Session {secret: "lkjmagsmohiuy324fm0p8yuagdshklmc190m82y3cr"}
app.use(bodyParser.json())
app.use(session)
app.set 'views', './views'
app.set 'view engine', 'jade'
app.use express.static "public"

io.use (socket, next) ->
  session socket.request, socket.request.res, next

router(app, io)

server.listen(3000)
