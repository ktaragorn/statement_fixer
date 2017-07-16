class NotImplementedError < Exception
end

require "./statement_fixer/*"
require "./statement_fixer/statement/*"
require "./statement_fixer/parsers/*"
require "optarg"

class Options < Optarg::Model
  arg "csv_file"
  string %w(-b --bank)
  string %w(-t --type)
end

module StatementFixer
  args = Options.parse(ARGV)
  puts args.csv_file
  puts args.bank
  puts args.type

  unless File.exists? args.csv_file
    raise "Specified file does not exist - #{args.csv_file}"
  end

  parser_key = "#{args.bank}_#{args.type}"
  unless ParserRegister.types.has_key? parser_key
    raise "Invalid/unsupported type type -  #{parser_key}"
  end

  parser = ParserRegister.types[parser_key].new(args.csv_file)
  parser.parse_into("parser_key")
end
