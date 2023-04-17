require_relative "produto"
require_relative "impresso"

class Livro < Produto

	include Impresso

	def initialize(titulo, preco, ano_lancamento, possui_reimpressao, editora, possui_sobrecapa)
		super(titulo, preco, ano_lancamento, editora)

		@possui_reimpressao = possui_reimpressao
		@possui_sobrecapa = possui_sobrecapa
	end

	def matches?(query)
		["livro", "impresso"].include(query)
	end

	public :possui_reimpressao?
end

class Float
	def para_dinheiro
		valor = "R$" << self.to_s.tr('.', ',')
		valor << 0 unless valor.match /(.*)(\d{2})$/
		valor
	end
end

class Conversor
	def string_para_alfanumerico (nome)
		nome.gsub /[^\w\s]/, ''
	end
end
