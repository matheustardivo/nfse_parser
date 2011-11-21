class Terceiro
  TERCEIROS = []
  
  attr_accessor :cpf_cnpj, :nome, :uf
  
  def initialize(args = {})
    TERCEIROS << self
    args.each {|key, value| __send__("#{key}=", value) }
  end
  
  def ==(other)
    cpf_cnpj == other.cpf_cnpj if other.respond_to?(:cpf_cnpj)
  end
end
