require "spec_helper"

describe NfseParser::Nota do
  it "parse com cpf" do
    nota = NfseParser::Nota.new(:xml => NfseParser::Prosoft::Parser::read("spec/resources/nfse_cpf.xml").join)
    nota.cpf_cnpj_cliente.should == "01603618856"
  end

  it "parse com cnpj" do
    nota = NfseParser::Nota.new(:xml => NfseParser::Prosoft::Parser::read("spec/resources/nfse_cnpj.xml").join)
    nota.cpf_cnpj_cliente.should == "00179497000157"
  end

  it "parse sem tomador" do
    nota = NfseParser::Nota.new(:xml => NfseParser::Prosoft::Parser::read("spec/resources/nfse_sem_cpf_cnpj.xml").join)
    nota.cpf_cnpj_cliente.should_not be
  end
end
