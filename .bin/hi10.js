#!/usr/bin/env node
const fs = require("fs");

const getUrls = (html) => {
  const hrefRegex = new RegExp('href="([^"]*?)"', "g");
  const matches = html.match(hrefRegex);
  if (matches === null) return [];
  return matches.map((item) => item.replace(hrefRegex, "$1"));
};

const filter = (links) => {
  var ads = [
    "https://ouo.io/s/QgcGSmNw?s=",
    "https://linkshrin.net/z2CR=",
    "https://spaste.com/r/LRZdw6?link=",
    "https://www.spaste.com/r/LRZdw6?link=",
    "http://www.spaste.com/r/LRZdw6?link=",
    "https://uiz.io/st?api=e725331590e7dff11fe0ae9037c8c435c9776047&url=",
    "https://uiz.io/st?api=e725331590e7dff11fe0ae9037c8c435c9776047&amp;url=",
    "https://391a5897.linkbucks.com/url/",
  ];
  var vids = [];
  links.forEach((link) => {
    if (link.includes(".mkv")) {
      ads.forEach((el) => (link = link.replace(el, "")));
      vids.push(link);
    }
  });
  return [...new Set(vids)];
};

if (process.argv.length < 2)
  console.log("Usage:\nhi10 <file> [<jtoken> optional]");
else
  fs.readFile(process.argv[2], "utf-8", (err, html) => {
    let jtoken = "57868f5255";
    if (process.argv[3] !== undefined) jtoken = process.argv[3];
    if (err) console.log("File I/O Error");
    else
      filter(getUrls(html)).forEach((link) => {
        console.log(link + "?jtoken=" + jtoken);
      });
  });
