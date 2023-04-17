require_relative "produto"

class Ebook < Produto

	def initialize(titulo, preco, ano_lancamento, editora)
		super(titulo, preco, ano_lancamento, editora)
	end


  def matches?(query)
		["ebook", "digital"].include(query)
	end

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
