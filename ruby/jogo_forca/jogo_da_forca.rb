require_relative 'ui'

def salva_rank (nome, pontos)
	conteudo = "#{nome}\n#{pontos}"
	File.write "rank.txt", conteudo
end

def le_rank
	conteudo = File.read "rank.txt"
	conteudo.split "\n"
end

def da_boas_vindas
	puts "Bem-vindo ao jogo da forca"
	puts "Qual o seu nome?"
	nome = gets.strip
	puts "\n\n\n\n"
	puts "Começaremos o jogo para você, #{nome}. "
	nome
end

def escolhe_palavra_secreta
	avisa_escolhendo_palavra

	texto = File.read "dicionario.txt"
	
	todas_as_palavras = texto.split "\n"


	palavra_secreta = todas_as_palavras[rand(todas_as_palavras.size)]

	avisa_palavra_escolhida palavra_secreta.size

	palavra_secreta
end

def nao_quer_jogar?
	puts "Deseja jogar novamente? <S/N>"
	quero_jogar = gets.strip
	nao_quero_jogar = quero_jogar.upcase =="N"
end


def palavra_mascarada chutes, palavra_secreta
	mascara = ""
	for letra in palavra_secreta.chars
		if chutes.include? letra
			mascara << letra 
		else
			mascara << " _ "
		end
	end
	mascara
end

def conta (texto, letra)
	total_encontrado = 0
	
	for caractere in texto.chars
		if caractere == letra
			total_encontrado += 1
		end
	end
	total_encontrado
end

def pede_chute_valido chutes, erros, mascara
	cabecalho_tentativa	erros, chutes, mascara
	loop do
		chute = pede_um_chute
		if chutes.include? chute
			alerta_chute_repetido
		else
			return chute
		end
	end
end

def joga(nome)
	palavra_secreta = escolhe_palavra_secreta

	erros = 0
	chutes = []
	pontos_ate_agora = 0

	while erros < 5
		mascara = palavra_mascarada chutes, palavra_secreta
		chute = pede_chute_valido chutes, erros, mascara

		chutes << chute

		chutou_uma_letra = chute.size == 1

		if chutou_uma_letra

			letra_procurada = chute[0]
			total_encontrado = palavra_secreta.count letra_procurada


			if total_encontrado == 0
				alerta_letra_nao_encontrada
				erros += 1
			else
				alerta_letra_encontrada total_encontrado
			end
		else
			acertou = chute == palavra_secreta
			if acertou
				alerta_acertou
				pontos_ate_agora +=100
				break
			else
				alerta_errou
				pontos_ate_agora -= 30
			end
		end

		#verifica se acertou ou errou
	end
	informa_pontos pontos_ate_agora
	pontos_ate_agora
end

def jogo_forca
	
	nome = da_boas_vindas
	pontos_totais = 0

	avisa_campeao_atual le_rank

	loop do
		
		pontos_totais += joga nome
		
		avisa_pontos_totais pontos_totais
		
		if le_rank[1].to_i < pontos_totais
			salva_rank nome, pontos_totais
		end

		if nao_quer_jogar?
			break
		end	
	end
end