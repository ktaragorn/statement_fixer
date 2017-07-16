class StatementRecord
  property date, description, income, expense, tag
  @date : Time | Nil
  @description : String | Nil
  @income : Float64 | Nil
  @expense : Float64 | Nil
  @tag : String | Nil

  def initialize(@date = nil, description = nil, income = nil, expense = nil, @tag : String | Nil = nil)
    self.description = description
    self.income = income
    self.expense = expense
  end

  def description=(description)
    @description = description.strip.gsub(/\s+/, "\s")
  end

  def income=(income)
    @income = income.to_f
  end

  def expense=(expense)
    @expense = expense.to_f
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

    unless date.is_a? Date
      raise "Invalid date #{date}"
    end

    [date, description, income, expense, tag]
  end
end
