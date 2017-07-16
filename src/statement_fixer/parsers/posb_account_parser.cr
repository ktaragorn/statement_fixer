require "./csv_parser"

class POSBAccountParser < CSVParser
  register "posb_account", self

  # Transaction Date Reference Debit Amount  Credit Amount Transaction Ref1  Transaction Ref2  Transaction Ref3
  # 27 Aug 2016 ICT   600 Anu Spending Cash Z073751608270739122994160827073912  OTHR

  def _parse_line(line)
    return unless (Date.parse(line[0]) rescue false)
    income = line[3]
    expense = line[2]
    description = "[#{line[1]}] #{line[4]}\n#{line[5]} (#{line[6]})"
    _write_to_statement line[0], description, income, expense
  end
end
