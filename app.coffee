express = require("express")
bodyParser = require("body-parser")
session = require("express-session")
io = require("socket.io")
router = require("./routes")

app = express()

app.use(bodyParser.json())
app.use(session({secret: "lkjmagsmohiuy324fm0p8yuagdshklmc190m82y3cr"}))
app.set 'views', './views'
app.set 'view engine', 'jade'
app.use express.static "public"

router(app)

app.listen(3000)
