class StatementRecord
  property date, description, income, expense

  def initialize(date = nil, description = nil, @income : Float32 | Nil = nil, @expense : Float32 | Nil = nil)
    self.date = date
    self.description = description
  end

  def date=(date)
    @date = Date.parse(date)
  end

  def description=(description)
    @description = description.strip.gsub(/\s+/, "\s")
  end

  def csv_meta
  end

  def csv_headers
    %w{date description income expense}
  end

  def csv_dump(headers)
    unless income || expense
      raise "Empty record #{self}"
    end

    unless date.is_a? Date
      raise "Invalid date #{date}"
    end

    [date, description, income, expense]
  end
end
