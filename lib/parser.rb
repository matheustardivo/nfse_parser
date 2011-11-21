# encoding: utf-8

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "nota"
require "terceiro"
require "prosoft"

# contents = File.readlines("../resources/nfse_201105_201111.xml")
# contents = File.readlines("../resources/nfse_small.xml")
# contents = File.readlines(ARGV[0])

contents = []
File.open(ARGV[0], "r:utf-8:iso-8859-1") do |f|
  while line = f.gets
    contents << line
  end
end

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
