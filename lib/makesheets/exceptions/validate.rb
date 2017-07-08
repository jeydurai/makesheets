#= Makesheets specific exception classes
class ColumnNotFoundError < StandardError

    attr_reader :column, :filename

    def initialize(column, filename, 
                   msg="[Error]: Queryable Excel column does not exist")
        @column = column
        @filename = filename
        super(msg)
    end

end
