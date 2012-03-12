# encoding: utf-8

module NfseParser
  class Nota
    NOTAS = []

    attr_accessor :xml, :data_emissao, :numero, :valor,
      :aliquota, :imposto, :base_calculo, :cpf_cnpj_cliente,
      :tipo, :uf_cliente

    def initialize(args = {})
      NOTAS << self
      @xml = ""

      if args.has_key?(:xml)
        add_xml(args[:xml])
        config!
      end

    end

    def add_xml(line)
      @xml << line.gsub("<?xml version = '1.0' encoding = 'UTF-8'?>", '').gsub(/ns[2-5]:/, '')
    end

    def config!
      xml.gsub!("\n", "")
      doc = Nokogiri::XML(xml, nil, 'utf-8')
      @data_emissao = Date.parse(doc.xpath("//DataEmissao").first.children.to_s[0..10])
      @numero       = doc.xpath("//IdentificacaoNfse/Numero").first.children.to_s.to_i
      @valor        = doc.xpath("//Servico/Valores/ValorServicos").first.children.to_s.to_f
      @aliquota     = doc.xpath("//Servico/Valores/Aliquota").first.children.to_s.to_f * 100
      @imposto      = valor * (aliquota / 100)
      @base_calculo = doc.xpath("//Servico/Valores/BaseCalculo").first.children.to_s.to_f
      @tipo         = "4NFS"

      unless doc.xpath("//TomadorServico").empty?
        @cpf_cnpj_cliente = doc.xpath("//TomadorServico/IdentificacaoTomador/CpfCnpj").children.children.to_s
        @uf_cliente       = doc.xpath("//TomadorServico/Endereco/Estado").first.children.to_s

        terceiro = Terceiro.new(
          :cpf_cnpj => @cpf_cnpj_cliente,
          :uf       => @uf_cliente,
          :nome     => doc.xpath("//TomadorServico/RazaoSocial").first.children.to_s
        )
      end

      self
    end
  end
end
