require "spec_helper"
require "nokogiri"

describe "Encoding" do
  it "ler encoding iso" do
    f = File.open("spec/resources/nfse_acentuacao.xml", "r:utf-8")
    f.external_encoding.name.should == "UTF-8"
  end
  
  it "ler linhas encoding iso" do
    contents = []
    File.open("spec/resources/nfse_acentuacao.xml", "r:utf-8") do |f|
      while line = f.gets
        contents << line
      end
    end
    
    # require "pry"; binding.pry
    
    Nota.new(:xml => contents.join)
    Prosoft::gerar_notas(Nota::NOTAS)
    Prosoft::gerar_terceiros(Terceiro::TERCEIROS)
    
    File.open("output/output.txt", "w:iso-8859-1") do |f|
      contents.each {|c| f.write c }
    end
    
    doc = Nokogiri::XML(contents.join.gsub("<?xml version = '1.0' encoding = 'UTF-8'?>", '').gsub(/ns[2-5]:/, ''), nil, 'utf-8')
    nome = doc.xpath("//TomadorServico/RazaoSocial").first.children.to_s
    
    # require "pry"; binding.pry
    
    File.open("output/terceiros_teste.txt", "w:iso-8859-1") do |f|
      f.write(nome)
    end
  end
end
