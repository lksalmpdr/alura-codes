function CidadesDAO(connection){
	this._connection = connection;
}


CidadesDAO.prototype.lista = function(callback){
	this._connection.query('select * from city', callback);
}

CidadesDAO.prototype.salva = function(produto, callback){
	this._connection.query('insert into city set ?, ?, ?', produto, callback);
}

module.exports = function(){
	return CidadesDAO;
}