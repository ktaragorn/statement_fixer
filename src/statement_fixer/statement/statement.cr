class Statement
  def initialize(suffix = "")
    @records = [] of StatementRecord
    @suffix = suffix
  end

  def <<(record)
    @records << record
  end

  def export_csv(file)
    file = file + @suffix + ".csv"
    CSV.open(file, "wb") do |csv|
      headers = @records.first.csv_headers
      csv << headers
      @records.each do |record|
        csv << record.csv_dump(headers)
      end
    end
    file
  end
end
