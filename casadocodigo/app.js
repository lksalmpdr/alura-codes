//var express = require('express');
//var app = express();
//var app = module.exports = express.createServer();

var app = require('./config/express')();
//require('./config/enviroment.js')(app, express);

//app.set("views", __dirname + "\\produtos\\views");
//app.set('view engine', 'jade');

//app.set('view engine', 'ejs');

//var routesProdutos = require('./app/routes/produtos')(app);
//app.set("views", __dirname + "\\app\\views");

app.listen(3000, function(){
	console.log("servidor rodando");
})