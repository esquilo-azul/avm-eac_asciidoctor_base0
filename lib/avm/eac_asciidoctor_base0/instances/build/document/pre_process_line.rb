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

            ARGUMENT_SEPARATOR = ','
            MACRO_PARSER = %r{\A\s*//\#(\S+)(?:\s+(.+))?\s*?\z}.to_parser do |m|
              ::Struct.new(:name, :arguments).new(m[1],
                                                  m[2].to_s.split(ARGUMENT_SEPARATOR).map(&:strip))
            end

            common_constructor :document, :line

            # @return [Array<String>]
            def result
              if macro?
                macro_value
              else
                [line]
              end
            end

            def macro?
              macro_name.present?
            end

            # @return [Array<String>, nil]
            def macro_arguments
              parsed_macro.if_present(&:arguments)
            end

            # @return [String, nil]
            def macro_name
              parsed_macro.if_present(&:name)
            end

            def macro_parser
              MACRO_PARSER
            end

            # @return [Array<String>]
            def macro_value
              document.macro_lines(macro_name, macro_arguments)
            end

            private

            def parsed_macro_uncached
              macro_parser.parse(line)
            end
          end
        end
      end
    end
  end
end
