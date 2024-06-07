var express = require('express');

var app = express();
app.get('/', function (req, res) {
  res.send('Hello world, Node.js app running on Docker');
});

var port = 5000;
app.listen(port, function () {
  console.log(`Server is running on http://localhost:${port}`);
});
