require 'makesheets/reader'
require 'makesheets/writer'
require 'makesheets/exceptions/validate'
# ==== Assembles all the required classes and processes
#
# === Reads from Excel file
# === Maps the matched data into the original base file
class Processor

    def initialize(options)
        @infile = options[:infile]
        @outfile = options[:outfile] || make_desti_file_name
        @source_sht = options[:sheet] || 0
        @skiprows = options[:skiprows] || 0
        @readrows = options[:readrows]
        @shtcol = options[:column]
        @prefix = options[:prefix]
    end

    # Makes destination file name from source file name
    def make_desti_file_name
        folder, file = File.split(@infile)
        extn = file[-5..-1]
        new_file = file[0..-6] + '_Result' + extn
        File.join(folder, new_file)
    end

    # Executes the process
    def process
        puts "[Info]: Process initiated..."
        @source = ExcelReader.new(@infile, @source_sht, @skiprows, 
                                  @readrows, @shtcol)
        unless column_exists? # Validates if the makesheet column exists
            begin
                raise ColumnNotFoundError.new(@shtcol, @infile)
            rescue => e
                puts "#{e.column} column does not exist in #{e.filename}!!!"
            end
            exit
        end
        @source.read
        ExcelWriter.new(@outfile, @source, @shtcol, @prefix).write
    end


    def column_exists?
        @source.headers.include?(@shtcol)
    end

    private :make_desti_file_name, :column_exists?
    public :process

end
