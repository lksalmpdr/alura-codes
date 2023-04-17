def alerta_chute_repetido
	puts "Você já deu esse chute!"
end

def alerta_letra_nao_encontrada
	puts "Letra não encontrada"
end

def alerta_letra_encontrada total_encontrado
	puts "Letra encontrada #{total_encontrado} vezes."
end

def alerta_acertou
	puts "Parabéns, você acertou!"
end

def alerta_errou
	puts "Que pena...você errou"
end

def informa_pontos pontos_ate_agora
	puts "Você ganhou #{pontos_ate_agora} pontos."
end

def cabecalho_tentativa erros, chutes, mascara
	puts "\n\n\n"
	puts "Erros até agora: #{erros}"
	puts "Chutes até agora: #{chutes}"
	puts "Palavra : #{mascara}"
end

def pede_um_chute
	puts "Entre com uma letra ou com uma palavra:"
	chute = gets.strip
	puts "Será que acertou? Você chutou #{chute}"
	chute
end

def avisa_pontos_totais pontos
	puts "Você tem #{pontos} até agora"
end

def avisa_campeao_atual(dados)
	puts "Nosso campeão é #{dados[0]} com #{dados[1]} pontos."
end

def avisa_escolhendo_palavra
	puts "Vamos escolher uma palavra secreta..."
end

def avisa_palavra_escolhida palavra_secreta
	puts "Palavra secreta com #{palavra_secreta} letras ... boa sorte!"
end