class Produto

  attr_reader :titulo, :ano_lancamento, :preco, :editora

  def initialize(titulo, preco, ano_lancamento, editora)
		@titulo = titulo
		@preco = preco
		@ano_lancamento = ano_lancamento
		@preco = calcula_preco(@preco)
		@editora = editora
	end


  def to_csv
		"#{@titulo}, #{@ano_lancamento}, #{@preco}"
	end

  def calcula_preco(valor_base)
		valor_base *= 0.9 if (@ano_lancamento < 2006) && (!possui_reimpressao?)
		valor_base *= 0.95 if (@ano_lancamento < 2006) && (not !possui_reimpressao?)
		valor_base *= 0.96 if (@ano_lancamento >= 2006) && (@ano_lancamento <= 2010)
		valor_base
	end
  private :calcula_preco
  public :to_csv
end
