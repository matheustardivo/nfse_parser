module NfseParser
  module Prosoft
    class Writer

      def self.file(file_name)
        File.open("output/" + file_name, "w:iso-8859-1") do |f|
          yield f
        end
      end

      def self.gerar_notas(notas)
        file("nfse_pjc.txt") do |f|
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

            f.write(linha)
          end
        end
      end

      def self.gerar_terceiros(terceiros)
        terceiros = terceiros.inject([]) { |resultado, t| resultado << t unless resultado.include?(t); resultado }

        file("terceiros_pjc.txt") do |f|
          terceiros.each do |terceiro|
            linha = "TRC"
            linha << " " * 7
            linha << "0"
            linha << "%-14s" % terceiro.cpf_cnpj

            if terceiro.nome
              linha << "%-60s" % terceiro.nome[0..59].gsub("&amp;", "&")
            else
              linha << " " * 60
            end

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

            f.write(linha)
          end
        end
      end
    end
  end
end
