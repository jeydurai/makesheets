# === Common module contains all Validation classes

module Validator
    # == Class container to validate files
    class FileValidator

        def initialize(file_name) #:notnew:
            @file_name = file_name
        end

        # Validates and returns true or false 
        #
        # Uses the Standard File class method file
        #
        #   valid = Validator::File(file_name)
        #   valid.validate
        def validate
            File.file?(@file_name)
        end

    end

end

