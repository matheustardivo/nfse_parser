module NfseParser
  module Prosoft
    module Parser
      extend self

      def read(file)
        contents = []
        File.open(file, "r:utf-8") do |f|
          while line = f.gets
            contents << line
          end
        end

        contents
      end

      def generate_all(file_name)
        contents = read(file_name)

        nota = Nota.new
        contents.each_with_index do |line, index|
          if line.start_with?("<ns2:NFSE") && index > 1
            nota = Nota.new
          end
          nota.add_xml(line)
        end

        Nota::NOTAS.each {|n| n.config! }

        Writer::gerar_notas(Nota::NOTAS)
        Writer::gerar_terceiros(Terceiro::TERCEIROS)
      end
    end
  end
end
