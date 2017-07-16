class StatementRecord
  attr_accessor :date, :description, :income, :expense

  def initialize(date = nil, description = nil, income = nil, expense = nil)
    self.date = date
    self.description = description
    @income = income
    @expense = expense
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
