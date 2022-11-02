# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Document
          class PreProcessLine
            enable_method_class
            enable_simple_cache

            MACRO_PARSER = %r{\A\s*//\#(\S+.*)}.to_parser do |m|
              m[1]
            end

            common_constructor :document, :line

            def result
              if macro?
                macro_value
              else
                line
              end
            end

            def macro?
              macro_name.present?
            end

            def macro_parser
              MACRO_PARSER
            end

            # @return [String]
            def macro_value
              document.send("#{macro_name}_macro_value").join("\n")
            end

            private

            def macro_name_uncached
              macro_parser.parse(line)
            end
          end
        end
      end
    end
  end
end
