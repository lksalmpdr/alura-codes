//var connectionFactory = require('../infra/connectionFactory'); retirado por conta do express-load
module.exports = function(app)
{
	var listarProdutos = function(req, res){
		var connection = app.infra.connectionFactory;
		var cidadesDAO = new app.infra.CidadesDAO(connection);

		cidadesDAO.lista(function(err, results){
			res.format({
				html: function(){
			    	res.render("produtos/lista",{lista:results});
			    },
				json: function(){
			    	res.json(results);
			    }
			});			
			//res.render("produtos/lista",{'lista' : results});
			//res.send(results);
		});

		connection.end();
	};

	app.get('/produtos', listarProdutos);

	app.get('/produtos/cadastro', function(req, res){
		res.render('produtos/form', {errosValidacao:{}, produto:{}});
	});

	app.post('/produtos', function(req, res){
		var produto = req.body;

		var validadorTitulo = req.assert('titulo', 'Título é obrigatório');

		validadorTitulo.notEmpty();

		var validatorPreco = req.assert('preco', 'Formato inválido').isFloat();


		var erros = req.validationErrors();

		if (erros){
			res.render('produtos/form', {errosValidacao:erros, produto:produto});
			return;
		}
		var connection = app.infra.connectionFactory;
		var cidadesDAO = new app.infra.CidadesDAO(connection);
		cidadesDAO.salva(produto, function(erros, resultados){
			res.redirect('/produtos');
			//res.render('/produtos/lista');
		})
	});
}
