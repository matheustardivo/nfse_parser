$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "nota"
require "terceiro"
require "prosoft"

contents = Prosoft::read(ARGV[0])

nota = Nota.new
contents.each_with_index do |line, index|
  if line.start_with?("<ns2:NFSE") && index > 1
    nota = Nota.new
  end
  nota.add_xml(line)
end

Nota::NOTAS.each {|n| n.config! }

Prosoft::gerar_notas(Nota::NOTAS)
Prosoft::gerar_terceiros(Terceiro::TERCEIROS)

# require "pry"; binding.pry
