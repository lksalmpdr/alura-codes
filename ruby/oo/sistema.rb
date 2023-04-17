require_relative "livro"
require_relative "revista"
require_relative "ebook"
require_relative "estoque"

def livros_para_newsletter(livro)
	if livro.ano_lancamento < 1999
		puts "Newsletter/Liquidação"
		puts livro.titulo
		puts livro.preco
	end
	puts "********************************"
end


def imprime_nota_fiscal(livros)
	livros.each do |livro|
		puts "------------------------------------------------"
		puts "Titulo: #{livro.titulo} \n Preço: #{livro.preco}"
		puts "------------------------------------------------"
	end
end


livro_ruby = Livro.new("Programming Ruby 1.9", 70, 2011, true, "Intrinseca", true)
livro_rails = Livro.new("Agile Web Development With Rails", 60.0, 2010, true, "Intrinseca", true)
livro_algoritmos = Livro.new("Algoritmos", 100, 1998, true, "Intrinseca", false)
livro_arquitetura = Livro.new("Introdução a Arquitetura e Design de Software", 70, 2011, true, "Intrinseca", false)
livro_pragmatico = Livro.new("The Pragmatic Programmer", 100, 1999, true, "Intrinseca", true)
livro_programacao_ruby = Livro.new("Programming Ruby", 100, 2004, true, "Intrinseca", false)

revistona = Revista.new("Algoritmos em Ruby", 10, 2012, true, "Atila", 11)
revistinha = Revista.new("Superman", 50, 1938, true, "Detective Comics", 1)

ebook_ruby = Ebook.new("Programming Ruby 1.9", 40, 2011, "Intrinseca")


livros = [livro_ruby, livro_rails, livro_algoritmos, livro_arquitetura, livro_pragmatico, livro_programacao_ruby]

# imprime_nota_fiscal(livros)

# livros_para_newsletter(livro_algoritmos)
# livros_para_newsletter(livro_rails)

estoque = Estoque.new
estoque << livro_ruby <<livro_ruby << livro_algoritmos << livro_algoritmos << livro_algoritmos
estoque.vende livro_ruby
estoque.vende livro_ruby
estoque.vende livro_algoritmos
estoque.vende livro_algoritmos
estoque.vende livro_algoritmos
puts estoque.livro_que_mais_vendeu_por_titulo()
# puts estoque.maximo_necessario
# estoque << livro_rails
# puts estoque.maximo_necessario
# estoque << livro_algoritmos
# puts estoque.maximo_necessario
# estoque << livro_arquitetura
# puts estoque.maximo_necessario
# estoque << livro_pragmatico
# puts estoque.maximo_necessario
# estoque << livro_programacao_ruby
# puts estoque.maximo_necessario
# estoque.vende livro_pragmatico
# puts estoque.maximo_necessario

# estoque.exporta_csv

# baratos = estoque.mais_baratos_que 80

# puts "Os livros mais baratos são: \n"
# baratos.each do |livro|
# 	puts "#{livro.titulo}: #{livro.preco}"
# end
# puts "*****************************************"

# estoque.exporta_csv
