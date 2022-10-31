# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Document
          class PreProcessLine
            enable_method_class
            common_constructor :document, :line

            def result
              line
            end
          end
        end
      end
    end
  end
end
