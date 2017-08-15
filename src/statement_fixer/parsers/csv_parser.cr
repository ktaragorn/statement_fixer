require "./parser"
require "csv"

class CSVParser < Parser
  def seperator
    ','
  end

  def _parse_file(input)
    CSV.each_row(File.read(input), seperator) do |line|
      _parse_line line if line.any? # do not attempt to parse empty lines
    end
  end

  def _parse_line(line)
    raise NotImplementedError.new("Implement this method on individual parsers")
  end
end
