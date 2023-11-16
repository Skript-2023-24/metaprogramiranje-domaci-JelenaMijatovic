class CustomColumn

    def initialize(column)
        @column = []
        @column += column
    end

    attr_accessor :column

    def [](row)
        @column[row]
    end

    def []=(row, num)
        @column[row]= num
    end

    def sum
        s = 0.0
        @column.each do |row|
            s = s + Float(row) rescue 0.0
        end
        s
    end

  def avg
    s = 0.0
    c = 0
    @column.each do |row|
      s = s + Float(row) rescue 0.0
      if (Float((row), exception: false))
        c += 1
      end
    end
    s/c
  end

    def method_missing(fun, *args, &block)
        if @column.respond_to?(fun.to_s)
            @column.send(fun.to_sym, &block)
        elsif @column.include?(fun.to_s)
            @column.index(fun.to_s)
        end
    end
end