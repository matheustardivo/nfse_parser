require "spec_helper"

describe "Encoding" do
  it "ler encoding iso" do
    f = File.open("spec/resources/nfse_acentuacao.xml", "r:iso-8859-1")
    f.external_encoding.name.should == "ISO-8859-1"
  end
  
  it "ler linhas encoding iso" do
    contents = []
    File.open("resources/nfse_201105_201111.xml", "r:utf-8") do |f|
      while line = f.gets
        contents << line
      end
    end
    
    File.open("output.txt", "w:iso-8859-1") do |f|
      contents.each {|c| f.write c }
    end
  end
end
