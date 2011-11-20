$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "nota"

#contents = File.readlines("../resources/nfse_201105_201111.xml")
#contents = File.readlines("../resources/nfse_small.xml")

contents = File.readlines(ARGV[0])

nota = Nota.new
contents.each_with_index do |line, index|
  if line.start_with?("<ns2:NFSE") && index > 1
    nota = Nota.new
  end
  nota.add_xml(line)
end

Nota::NOTAS.each {|n| n.config }

require "pry"; binding.pry
