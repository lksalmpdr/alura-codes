def avisa_boas_vindas
	puts "Bem-vindo ao foge-foge"
	puts "\n\n\n\n"
	puts "Qual o seu nome?"
	nome = gets.strip
	puts "\n\n\n\n"
	puts "Começaremos o jogo #{nome}"
	nome
end

def desenha (mapa)
	puts mapa
end

def pede_movimento
	puts "Para qual direção deseja ir?"
	movimento = gets.strip
end

def game_over
	puts "Você perdeu!"
end