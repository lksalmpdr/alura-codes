var mysql = require('mysql');

function createDBConnection(){
	return mysql.createConnection
	({
	host : '127.0.0.1',
	user : 'root',
	password : '',
	database : 'world',
	});
 }	
// connection.connect(function(err){
//   if (err) {
// 	console.error('error connecting: ');
// 	return;
//   }
// });


//wrapper
module.exports = function(){
	return createDBConnection();
}