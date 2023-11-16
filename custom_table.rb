require "google_drive"
require "matrix"
require_relative "custom_column"

class CustomTable

  include Enumerable

  def initialize(worksheet)
    @worksheet = worksheet
    @table = []
    @columns = {}
    make_table()
    make_columns()
  end

  attr_reader :table

  def make_table
    (1..@worksheet.num_rows).each do |row|
      crow = []
      (1..@worksheet.num_cols).each do |col|
        crow << @worksheet[col, row]
      end
      unless crow.include?("total") || crow.include?("subtotal") 
        @table << crow
      end
    end
  end

  def make_columns
    (1..@worksheet.num_cols).each do |col|
      column = []
      (2..@worksheet.num_rows).each do |row|
          column << @worksheet[row, col]
      end
      title = @worksheet[1, col].gsub(" ", "")
      title[0] = title[0].downcase
      @columns[title]= CustomColumn.new(column)
    end
  end

  def row(num)
    @worksheet.rows[num]
  end

  def each
    (1..@worksheet.num_rows).each do |row|
      (1..@worksheet.num_cols).each do |col|
        yield @worksheet[row, col]
      end
    end
  end

  def [](title)
    title = title.to_s.gsub(" ", "")
    title[0] = title[0].downcase
    @columns[title]
  end

  def method_missing(col, *args)
    self[col]
  end

end
