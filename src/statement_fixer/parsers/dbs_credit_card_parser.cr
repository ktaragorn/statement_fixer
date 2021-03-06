require "./csv_parser"

class DBSCreditCardParser < CSVParser
  register "dbs_credit_card", self

  def seperator
    '\t'
  end

  def _parse_line(line)
    date = Time.parse_utc(line[0], "%d %b %Y") rescue nil # %d-%b-%y
    return unless date
    income, expense = if line[2].ends_with? "cr"
                        [line[2][2..-3], "0"]
                      else
                        ["0", line[2][2..-1]]
                      end
    _write_to_statement date, line[1], income, expense
  end
end
