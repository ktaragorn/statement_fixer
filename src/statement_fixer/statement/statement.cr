class Statement
  property suffix

  def initialize(@suffix = "")
    @records = [] of StatementRecord
  end

  def <<(record : StatementRecord)
    @records << record
  end

  def export_csv(file)
    file = file + @suffix + ".csv"
    csv = CSV.build do |csv|
      headers = @records.first.csv_headers
      csv.row headers
      @records.each do |record|
        csv.row record.csv_dump(headers)
      end
    end
    File.write(file, csv)
    file
  end
end
