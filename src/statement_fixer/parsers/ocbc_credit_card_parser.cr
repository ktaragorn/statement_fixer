require "./csv_parser"

class OCBCCreditCardParser < CSVParser
  register "ocbc_credit_card", self

  # Main Credit CardOCBC 365 Credit Card 4524-1920-0283-6744
  # Transaction date  Description Withdrawals (SGD) Deposits (SGD)
  # 29/09/2016  CASH REBATE   1.41

  # Supplementary CardsOCBC 365 Credit Card 4524-1920-0270-4736
  # Transaction date  Description Withdrawals (SGD) Deposits (SGD)
  # 29/09/2016  JUICE BAR - 313 SOMERSET SINGAPORE    SG  1.6

  def _parse_line(line)
    # note there could be multiple Supplementary cards
    if line[0].starts_with? "Main"
      @tag = "main"
    elsif line[0].starts_with? "Supplementary"
      @tag = "supplementary"
    end
    date = Time.parse(line[0], "%d/%m/%Y") rescue nil
    return unless date
    _write_to_statement date, line[1], line[2], line[3], @tag
  end
end
