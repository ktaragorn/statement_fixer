require "./csv_parser"

class DBSCreditCardParser < CSVParser
  register "dbs_credit_card", self

  def _parse_line(line)
    date = Time.parse(line[0], "%d-%b-%y") rescue nil
    return unless date
    income, expense = if line[2].ends_with? "cr"
                        [line[2][2..-1].to_f, 0]
                      else
                        [0, line[2][2..-1].to_f]
                      end
    _write_to_statement date, line[1], income, expense
  end
end
