#!/usr/bin/env node
const { exec } = require("child_process");
const http = require("http");
exec("notify-send 'Remote Shell Service Started!'", () => {});
http
  .createServer(function (req, res) {
    var cmd = "";
    req.on("data", (chunk) => {
      cmd += chunk;
    });
    req.on("end", () => {
      res.write("Executing!");
      exec(cmd, () => {});
      res.end();
    });
  })
  .listen(6969, function () {
    console.log("Shutdown server started");
  });
