require "./csv_parser"

class DBSCreditCardParser < CSVParser
  register "dbs_credit_card", self

  def _parse_line(line)
    return unless (Date.parse(line[0]) rescue false)
    income, expense = if line[2].end_with? "cr"
                        [line[2][2..-1].to_f, 0]
                      else
                        [0, line[2][2..-1].to_f]
                      end
    _write_to_statement line[0], line[1], income, expense
  end
end
