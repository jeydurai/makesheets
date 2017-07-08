require "makesheets/version"
require 'makesheets/validator'
require 'makesheets/processor'

#= Entry point, which validates and deligates the task
module Makesheets

    # Validator and Delegator
    def self.run(options)
        #puts options.inspect
        unless options[:infile]
            puts "[Error]: File path of the spreadsheet is required"
            exit
        end
        unless options[:column]
            puts "[Error]: Key column name must be given"
            exit
        end
        unless Validator::FileValidator.new(options[:infile]).validate
            puts "[Error]: #{options[:infile]} is not a valid infile!!!"
            exit
        end
        if options[:outfile]
            unless Validator::FileValidator.new(options[:outfile]).validate
                puts "[Error]: #{options[:outfile]} is not a valid outfile!!!"
                exit
            end
        end
        if options[:skiprows]
            options[:skiprows] = options[:skiprows].to_i
        end
        if options[:readrows]
            options[:readrows] = options[:readrows].to_i
        end
        Processor.new(options).process
    end

end
