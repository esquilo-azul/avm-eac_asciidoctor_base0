# frozen_string_literal: true

require 'avm/eac_generic_base0/file_formats/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module FileFormats
      class Base < ::Avm::EacGenericBase0::FileFormats::Base
        class FileResourceName
          enable_method_class
          common_constructor :file_format, :path do
            self.path = path.to_pathname
          end

          CONTENT_PATTERNS = [%r{content/(.+)\z}].freeze

          # @param path [Pathname]
          # @return [Avm::FileFormats::FileWith]
          def result
            result_from_content || file_format.result_from_superclass(path)
          end

          private

          def result_from_content
            file_format.result_from_patterns(CONTENT_PATTERNS, path) do |m|
              r = ::File.dirname(m[1])
              r = '' if r == '.'
              "Content[/#{r}]"
            end
          end
        end
      end
    end
  end
end
