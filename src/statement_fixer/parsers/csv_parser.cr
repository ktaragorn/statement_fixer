require "./parser"
require "csv"

class CSVParser < Parser
  def _parse_file(input)
    CSV.foreach(input) do |line|
      _parse_line line
    end
  end

  def _parse_line(line)
    raise NotImplementedError.new("Implement this method on individual parsers")
  end
end
