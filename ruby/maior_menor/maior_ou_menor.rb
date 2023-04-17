puts "Bem-vindo ao jogo"
puts "Digite o nome"

nome = gets
puts "\n"
puts "Vamos começar, " + nome
puts "\n"
puts "Escolha um numero secreto entre 0 e 200..."

numero_secreto = 175
puts "\n\n"
puts "Valor escolhido, faça a primeira tentativa: "
puts "Tentativa 1"
puts "\n\n"
puts "Entre com um número"
chute = gets
puts "Será que acertou? Você chutou " + chute
puts chute.to_i == numero_secreto