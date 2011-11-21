require "date"
require "ibge"

module Prosoft
  def self.read(file)
    contents = []
    File.open(file, "r:utf-8") do |f|
      while line = f.gets
        contents << line
      end
    end
    
    contents
  end
  
  def self.file(file)
    File.open("output/" + file, "w:iso-8859-1") do |file|
      yield file
    end
  end
  
  def self.gerar_notas(notas)
    Prosoft::file("nfse_pjc.txt") do |file|
      notas.each do |nota|
        linha = ""
        linha << " "
        linha << nota.data_emissao.strftime("%d%m%y")
        linha << " " * 3
        linha << "%06d" % nota.numero
        linha << " " * 11
        linha << "%014.2f" % nota.valor
        linha << "%05.2f" % nota.aliquota
        linha << "%014.2f" % nota.imposto
        linha << " " * 104
        linha << "%014.2f" % nota.base_calculo
        linha << " " * 62
        linha << "%-14s" % nota.cpf_cnpj_cliente
        linha << " " * 56
        # linha << "%-5s" % nota.tipo
        linha << " " * 5
        linha << " " * 387
        linha << "%-2s" % nota.uf_cliente
        linha << " " * 255

        linha << "\r\n"
        
        file.write(linha)
      end
    end
  end
  
  def self.gerar_terceiros(terceiros)
    terceiros = terceiros.inject([]) { |resultado, t| resultado << t unless resultado.include?(t); resultado }
    
    Prosoft::file("terceiros_pjc.txt") do |file|
      terceiros.each do |terceiro|
        linha = "TRC"
        linha << " " * 7
        linha << "0"
        
        if terceiro.cpf_cnpj == "05954659000109"
          # require "pry"; binding.pry
        end
        
        linha << "%-14s" % terceiro.cpf_cnpj
        linha << "%-60s" % terceiro.nome[0..59].gsub("&amp;", "&")
        linha << " " * 189
        linha << "%-2s" % terceiro.uf
        linha << "20080101"
        linha << " " * 140
        linha << " " * 84
        linha << "%04d" % 1058
        if terceiro.uf
          linha << Ibge::CODIGOS[terceiro.uf.to_sym]
        else
          linha << " " * 5
        end
        linha << " " * 85

        linha << "\r\n"
        
        file.write(linha)
      end
    end
  end
end
