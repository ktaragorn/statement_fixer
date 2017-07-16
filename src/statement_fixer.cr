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
end
