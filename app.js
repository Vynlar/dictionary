(function() {
  var app, bodyParser, express, io, router, session;

  express = require("express");

  bodyParser = require("body-parser");

  session = require("express-session");

  io = require("socket.io");

  router = require("./routes");

  app = express();

  app.use(bodyParser.json());

  app.use(session({
    secret: "lkjmagsmohiuy324fm0p8yuagdshklmc190m82y3cr"
  }));

  router(app);

  app.listen(3000);

}).call(this);