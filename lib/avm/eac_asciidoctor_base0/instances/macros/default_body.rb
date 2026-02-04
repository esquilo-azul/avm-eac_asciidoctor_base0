# frozen_string_literal: true

module Avm
  module EacAsciidoctorBase0
    module Instances
      module Macros
        class DefaultBody < ::Avm::EacAsciidoctorBase0::Instances::Macros::Base
          RESULT_LINES = ['== Índice', '', '//#child_docs'].freeze

          # @return [Array<String>]
          def result
            RESULT_LINES
          end
        end
      end
    end
  end
end
