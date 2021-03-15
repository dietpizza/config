#!/usr/bin/env node
const fs = require("fs");
const crypto = require("crypto");

var dirs = ["/run/media/rohan/T1/Best/", "/run/media/rohan/T1/Xvid/"];
dirs.forEach((dir) => {
  fs.readdirSync(dir).forEach((el) => {
    fs.renameSync(
      dir + el,
      dir + crypto.randomBytes(10).toString("hex") + ".mp4"
    );
  });
});
