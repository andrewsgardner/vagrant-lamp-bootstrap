// DEPENDENCIES
// ============

var express = require("express"),
    app = express(),
    bodyParser = require("body-parser"),
    path = require("path"),
    logger = require('morgan'),
    mongojs = require("mongojs"),
    db = mongojs("vagrantStack", ["siteData"]);

// MIDDLEWARE
// ==========

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, "/../public_html")));

// ROUTES
// ==========

app.get('/', function(req, res) {
  res.send('It works!');
});

// NODE SERVER
// ===========

app.listen(3000);
console.log('Welcome to vagrantStack!\n\nListening on port 3000...');
