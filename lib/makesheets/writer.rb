require 'rubyXL'

# == Container for Excel writing functionalities
class ExcelWriter
    attr_reader :data, :data_shtcols

    def initialize(filename, reader, shtcol, prefix) #:notnew:
        @filename = filename
        @data = reader.data
        @headers = reader.headers
        @data_shtcols = reader.data_shtcols
        @shtcol = shtcol
        @prefix = prefix
        @is_header_written = {}
        @wb = RubyXL::Workbook.new
        @main_sht = @wb.worksheets[0]
    end

    # Executes Write action
    def write
        puts "[Info]: Writing headers in main sheet..."
        write_header(@main_sht) # Write header in main sheet
        puts "[Info]: Core data writing initiated"
        write_data
        @wb.write(@filename)
        puts "[Info]: Result file has been written to #{@filename}"
    end

    # Writes in main sheet with all the data
    def write_main row, col, val
        @main_sht.add_cell(row, col, val)
    end

    # Writes column headers in a given sheet
    def write_header sht 
        @headers.each_with_index do |h, i|
            sht.add_cell(0, i, h)
        end
    end

    # Writes the records/data
    def write_data
        @data.each_with_index do |d, i|
            d.each_with_index do |(k, v), j|
               write_main(i+1, j, v)
            end
            write_individual(d, i+1)
        end
    end

    # Make sheets and write for the unique data
    # ---
    # Excel accepts only 30 max characters as sheet name
    def write_individual d, row
        _key = d[@shtcol]
        key_data = _key.instance_of?(Fixnum) ? _key.to_s : _key
        sht_name = @prefix ? @prefix + '_' + key_data : key_data
        if sht_name.length > 30 # In case sheet name is greater than 30 chars
            slice_len = sht_name.length - 30 + 1
            sht_name = sht_name.slice(-slice_len..slice_len)
        end
        sht = @wb[sht_name] ? @wb[sht_name] : @wb.add_worksheet(sht_name)
        unless @is_header_written.has_key?(key_data)
            write_header(sht)
            @is_header_written[key_data] = { 
                :header => true, 
                :row => 1
            }
        end
        d.each_with_index do |(k, v), j|
            sht.add_cell(@is_header_written[key_data][:row], j, v)
        end
        @is_header_written[key_data][:row] += 1
    end

    private :write_header, :write_data, :write_main, :write_individual
    public :write

end

