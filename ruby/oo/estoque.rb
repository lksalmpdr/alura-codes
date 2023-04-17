require_relative "contador"

class Estoque
	attr_reader :livros

	def initialize()
		@livros = []
		@livros.extend Contador
		@vendas = []
	end

	def exporta_csv()
		@livros.each do |livro|
			puts livro.to_csv
		end
	end

	def mais_baratos_que(valor)
		@livros.select do |livro|
			livro.preco <= valor
		end
	end

	def total
		@livros.size
	end

	def <<(livro)
		@livros << livro if livro
		self
	end

	def vende(livro)
		@livros.delete livro
		@vendas << livro
	end

	def maximo_necessario
		@livros.maximo_necessario
	end

	def livros_computacao
		unicos = []
		self.each do |item|
			unicos.push(item) unless unicos.include?(item)
		end
		unicos.length
	end

	def method_missing(name)
		comparador = name.to_s.match "(.+)_que_mais_vendeu_por(.+)"
		if comparador
			tipo = comparador[1]
			campo = comparador[2].to_sym
			que_mais_vendeu_por(tipo, campo)
		else
			super
		end
	end

	def respond_to?(name)
		matcher = name.to_s.match "(.+)_que_mais_vendeu_por(.+)"
		!!(matcher) || super
	end

	public :exporta_csv, :total, :mais_baratos_que, :<<, :maximo_necessario




		def quantidade_vendas (produto, &campo)
			@vendas.count {|venda| campo.call(venda) == campo.call(produto)}
		end


		def que_mais_vendeu_por(tipo, &campo)
			@vendas.select{|produto| produto.matches?(tipo)}.sort {|v1, v2|
				quantidade_vendas(v1, campo.call(produto)) <=> quantidade_vendas(v2, campo.call(produto))}.last
		end

		private :quantidade_vendas, :que_mais_vendeu_por
end
