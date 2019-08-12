require "./csv_parser"

class POSBAccountParser < CSVParser
  register "posb_account", self

  # Transaction Date Reference Debit Amount  Credit Amount Transaction Ref1  Transaction Ref2  Transaction Ref3
  # 27 Aug 2016 ICT   600 Anu Spending Cash Z073751608270739122994160827073912  OTHR

  def _parse_line(line)
    date = Time.parse_utc(line[0], "%d %b %Y") rescue nil
    return unless date
    income = line[3]
    expense = line[2]
    description = "[#{line[1]}] #{line[4]} #{line[5]}"
    description += " (#{line[6]})" unless line[6].blank?
    _write_to_statement date, description, income, expense
  end
end
