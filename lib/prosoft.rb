require "date"

class Prosoft
  attr_reader :notas
  
  def initialize(notas)
    @notas = notas
  end
  
  def gerar_arquivo
    notas.each do |nota|
      linha = ""
      linha << nota.data_emissao.strftime("%d%m%y")
    end
  end
end
