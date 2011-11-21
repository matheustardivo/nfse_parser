require "spec_helper"

describe Array do
  it "group array" do
    Terceiro.new(cpf_cnpj: "Matheus")
    Terceiro.new(cpf_cnpj: "Dunha")
    Terceiro.new(cpf_cnpj: "Chico")
    Terceiro.new(cpf_cnpj: "Matheus")
    
    arr = Terceiro::TERCEIROS
    arr = arr.inject([]) { |resultado, t| resultado << t unless resultado.include?(t); resultado }
    
    arr.should be_kind_of(Array)
    arr.size.should == 3
  end
end
