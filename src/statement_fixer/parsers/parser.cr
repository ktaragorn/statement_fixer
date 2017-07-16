require_relative "../statement/statement"
require_relative "../statement/statement_record"

class Parser
  attr_reader :statements, :statement
  @@types = {} of String => Parser

  def self.register(type, klass)
    @@types[type] = klass
  end

  def self.types
    @@types
  end

  def initialize(input)
    @statements = [Statement.new]
    @statement = @statements.first
    @statement_record = nil
    _parse_file input
    _finalize_statement
  end

  def parse_into(output)
    @statements.map do |statement|
      statement.export_csv(output)
    end
  end

  def _parse_file(input)
    raise NotImplementedError, "Implement this method on individual parsers"
  end

  def _write_to_statement(date = nil, description = nil, income = nil, expense = nil)
    if @statement_record
      @statement << @statement_record
    elsif date
      @statement << StatementRecord.new(date, description, income, expense)
    end
    @statement_record = nil
  end

  def _new_statement(suffix = "")
    _finalize_statement
    @statement = Statement.new(suffix)
    @statements << @statement
  end

  def _finalize_statement
    # any final steps to statement should go here
    _write_to_statement
  end
end
