require "date"
require "nokogiri"

class Nota
  NOTAS = []
  
  attr_accessor :xml, :data_emissao, :numero, :valor, 
                :aliquota, :imposto, :base_calculo, :cpf_cnpj_cliente, 
                :tipo, :ie_cliente, :uf_cliente
  
  def initialize
    Date.strptime '03/21/2011', '%m/%d/%Y'
    NOTAS << self
    @xml = ""
  end
  
  def add_xml(line)
    @xml << line.gsub("<?xml version = '1.0' encoding = 'UTF-8'?>", '').gsub(/ns[2-5]:/, '')
  end
  
  # Data da emissao da NF.
  # Nota Fiscal. 1o número => número da nota
  # Valor Contábil
  # Aliquota
  # Valor Imposto => valor contábil * aliquota (se aliquota > 0)
  # (1) Base de Calculo
  # CNPJ / CPF do cliente
  # Tipo de Nota/Espécie do Documento
  # Cliente Inscrição Estadual => não encontrei
  # Cliente UF
  def config
    xml.gsub!("\n", "")
    doc = Nokogiri::XML(xml)
    @data_emissao = Date.parse(doc.xpath("//DataEmissao").first.children.to_s[0..10])
    @numero = doc.xpath("//IdentificacaoNfse/Numero").first.children.to_s.to_i
    @valor = doc.xpath("//Servico/Valores/ValorServicos").first.children.to_s.to_f
    @aliquota = doc.xpath("//Servico/Valores/Aliquota").first.children.to_s.to_f * 100
    @imposto = valor * (aliquota / 100)
    @base_calculo = doc.xpath("//Servico/Valores/BaseCalculo").first.children.to_s.to_f
    @tipo = "NFSe"
    
    unless doc.xpath("//TomadorServico").empty?
      @cpf_cnpj_cliente = doc.xpath("//TomadorServico/IdentificacaoTomador/CpfCnpj").children.children.to_s
      @uf_cliente = doc.xpath("//TomadorServico/Endereco/Estado").first.children.to_s
    end
    
    self
  end
end
