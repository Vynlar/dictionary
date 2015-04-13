express = require("express")
bodyParser = require("body-parser")
session = require("express-session")
Server = require("http").Server
router = require("./routes")

app = express()
server = Server(app)
io = require("socket.io")(server)

app.use(bodyParser.json())
app.use(session({secret: "lkjmagsmohiuy324fm0p8yuagdshklmc190m82y3cr"}))
app.set 'views', './views'
app.set 'view engine', 'jade'
app.use express.static "public"

router(app)

server.listen(3000)
