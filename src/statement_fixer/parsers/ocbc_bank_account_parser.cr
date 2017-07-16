require "./csv_parser"

class OCBCBankAccountParser < CSVParser
  register "ocbc_account", self

  def _parse_line(line)
    @state ||= :summary
    if @state == :summary && line[0].to_s.downcase == "transaction date"
      @state = :records
    elsif @state == :records
      if !line[0].to_s.strip.empty?
        _write_to_statement
        @statement_record = StatementRecord.new(Time.parse(line[0], "%d/%m/%Y"), line[2], line[4], line[3])
      elsif line[2] && (s = @statement_record)
        s.description = s.description.to_s + " " + line[2]
      end
    end
  end
end
