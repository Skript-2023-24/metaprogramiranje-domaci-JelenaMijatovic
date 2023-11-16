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
        crow << @worksheet[row, col]
      end
      unless crow.include?("total") || crow.include?("subtotal") 
        @table << crow
      end
    end
  end

  def make_columns
    (1..@table[0].size).each do |col|
      column = []
      @table[1..@table.size-1].each do |row|
        column << row[col-1]
      end
      title = @table[0][col-1].gsub(" ", "")
      title[0] = title[0].downcase
      @columns[title]= CustomColumn.new(column)
    end
  end

  def row(num)
    @table[num]
  end

  def each
    @table.each do |row|
      (1..row.size).each do |col|
        yield row[col-1]
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

  def +(t1)
    sum = []
    i = 1
    if @table[0] == t1.table[0]
      @table[1..@table.size-1].each do |row|
        sum << row + t1.table[i]
        i += 1
      end
    end
    sum
  end

end
