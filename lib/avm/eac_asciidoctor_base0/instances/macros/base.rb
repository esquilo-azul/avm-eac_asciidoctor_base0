# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      module Macros
        class Base
          enable_abstract_methods
          common_constructor :document

          # @return [Array<String>]
          def result
            raise_abstract_method __method__
          end
        end
      end
    end
  end
end
