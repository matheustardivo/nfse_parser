require "spec_helper"

module NfseParser
  describe Nota do
    it "parse com cpf" do
      nota = Nota.new(:xml => Prosoft::Parser::read("spec/resources/nfse_cpf.xml").join)
      nota.cpf_cnpj_cliente.should == "01603618856"
    end

    it "parse com cnpj" do
      nota = Nota.new(:xml => Prosoft::Parser::read("spec/resources/nfse_cnpj.xml").join)
      nota.cpf_cnpj_cliente.should == "00179497000157"
    end

    it "parse sem tomador" do
      nota = Nota.new(:xml => Prosoft::Parser::read("spec/resources/nfse_sem_cpf_cnpj.xml").join)
      nota.cpf_cnpj_cliente.should_not be
    end
  end
end
