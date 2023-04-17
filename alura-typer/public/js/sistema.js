var tempoInicial = $("#tempo").text();
var campo = $(".campo-digitacao");


$(function(){
	atualizaTamanhoFrase();
	iniciaContadores();
	iniciaCronometro();
	iniciaMarcadores();
	$("#reinicia-jogo").click(reiniciaJogo);
});




function removeLinha(){
	event.preventDefault();
	$(this).parent().parent().remove();
}

function inserePlacar(){
    var corpoTabela = $("table").find("tbody");
    var usuario = "Seu-nome";
    var numPalavras = $(".contador-palavras").text();

    var linha = novaLinha(usuario, numPalavras);
    linha.find("botao-remover").click(removeLinha)

    corpoTabela.append(linha);
}

function novaLinha(nome, palavras){
	var linha = $("<tr>");
	var colunaNome = $("<td>").text(nome);
	var colunaQtdPalavras = $("<td>").text(palavras);
	var colunaAcao = $("<td>");
	var ancora = $("<a>").attr("href", "#").addClass("botao-remover");
	var iconeRemover = $("<i>").addClass("small material-icons").text("delete");

	ancora.append(iconeRemover);
	colunaAcao.append(ancora);
	linha.append(colunaNome);
	linha.append(colunaQtdPalavras);
	linha.append(colunaAcao);

	return linha;
}

function atualizaTamanhoFrase(){
	var frase = $("#frase").text();
	var tamanho_frase = frase.split(" ").length; 
	$("#tamanho").text(tamanho_frase);
}


function iniciaContadores() {
	campo.on("input", function(){
		var conteudo = campo.val();

		var qtd_caracteres_digitadas = conteudo.length;
		var qtd_palavras_digitadas = conteudo.split(/\S+/).length - 1;
		$("#qtd_palavras").text(qtd_palavras_digitadas);
		$("#qtd_caracteres").text(qtd_caracteres_digitadas);
	});
}

function iniciaMarcadores(){
	var frase = $('#frase').text();
	campo.on("input", function(){
		var digitado = campo.val();
		var comparavel = frase.substr(0, digitado.length)
		if(digitado == comparavel){
            campo.addClass("borda-verde");
            campo.removeClass("borda-vermelha");
		}else{
            campo.addClass("borda-vermelha");
            campo.removeClass("borda-verde");			
		}		
	})
}

function iniciaCronometro(){
	var tempoRestante = $("#tempo").text();
	campo.one("focus", function(){
	$("#reinicia-jogo").attr("disabled",true);
	var cronometroId = setInterval(function(){
		tempoRestante--;
		$("#tempo").text(tempoRestante);
		if (tempoRestante < 1){
			clearInterval(cronometroId);
			finalizaJogo();
		}
	}, 1000);		
	});
}

function finalizaJogo(){
	campo.attr("disabled", true);
	$("#reinicia-jogo").attr("disabled", false);
	campo.addClass("campo-desativado"); //toggleClass()	
	inserePlacar();
}


$("#reinicia-jogo").click(reiniciaJogo);
function reiniciaJogo(){
	campo.attr("disabled", false);
	campo.val("");
	$("#qtd_palavras").text("0");
	$("#qtd_caracteres").text("0");
	$("#tempo").text(tempoInicial);
	campo.removeClass("campo-desativado"); //toggleClass()
	iniciaCronometro();
    campo.removeClass("borda-vermelha"); //novo
    campo.removeClass("borda-verde"); //novo	

}
