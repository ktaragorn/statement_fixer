class StatementRecord
  property date, description, income, expense, tag
  @date : Time | Nil
  @description : String | Nil
  @income : Float64 | Nil
  @expense : Float64 | Nil
  @tag : String | Nil

  def initialize(@date = nil, description = nil, income : String = nil, expense : String = nil, @tag : String | Nil = nil)
    self.description = description
    self.income = income
    self.expense = expense
  end

  def description=(description)
    @description = description.strip.gsub(/\s+/, " ")
  end

  def income=(income)
    @income = income.blank? ? 0.0 : income.gsub(",", "").to_f # :( ugly but necessary to handle case where the value is ""
  end

  def expense=(expense)
    @expense = expense.blank? ? 0.0 : expense.gsub(",", "").to_f # :( ugly but necessary to handle case where the value is ""
  end

  def csv_meta
  end

  def csv_headers
    %w{date description income expense tag}
  end

  def csv_dump(headers)
    unless income || expense
      raise "Empty record #{self}"
    end

    unless (d = date).is_a? Time
      raise "Invalid date #{d}"
    end

    [d.to_s("%Y-%m-%d"), description, income, expense, tag]
  end
end
