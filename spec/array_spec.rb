require "spec_helper"

describe Array do
  it "group array" do
    NfseParser::Terceiro.new(:cpf_cnpj => "Matheus")
    NfseParser::Terceiro.new(:cpf_cnpj => "Dunha")
    NfseParser::Terceiro.new(:cpf_cnpj => "Chico")
    NfseParser::Terceiro.new(:cpf_cnpj => "Matheus")

    arr = NfseParser::Terceiro::TERCEIROS
    arr = arr.inject([]) { |resultado, t| resultado << t unless resultado.include?(t); resultado }

    arr.should be_kind_of(Array)
    arr.size.should == 3
  end
end
