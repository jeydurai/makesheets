require 'roo'

# Contains functionalities for reading content from Excel
class ExcelReader

    attr_reader :data, :headers, :data_shtcols

    def initialize(filename, sheet, skiprows, readrows, shtcol) #:notnew:
        @filename = filename
        @shtcol = shtcol
        @data = []
        @data_shtcols = [] # container to hold all unique data of makesheet col
        set_file_credentials(sheet, skiprows, readrows)
    end

    # Sets last_row, last_column, headers, etc
    def set_file_credentials(sht, skip, read)
        puts "[Info]: Validation & setting file credentials are on progress..."
        @sht = Roo::Excelx.new(@filename).sheet(sht)
        @lrow = @sht.last_row
        @lcol = @sht.last_column
        @skiprows = skip
        @headers = @sht.row(@skiprows+1)
        @readrows = read ? read+@skiprows : @lrow
    end

    # Iterates over rows and stores the data as list of hashes
    def read
        puts "[Info]: Data reading on progress..."
        @lrow.times do |i|
            row_idx = i + 1
            next if row_idx <= @skiprows+1
            row_data = @sht.row(row_idx)
            row_dict = {}
            @headers.each_with_index do |h, j|
                temp_dict = { h => row_data[j] }
                @data_shtcols << row_data[j] if h == @shtcol
                row_dict.merge!(temp_dict)
            end
            @data << row_dict
            break if row_idx > @readrows
        end
        len_before = @data_shtcols.length
        @data_shtcols.uniq!
        len_after = @data_shtcols.length
        puts "[Info]: Column data count=#{len_before} [Bef] #{len_after} [Aft]"
    end

    private :set_file_credentials
    public :read
end







