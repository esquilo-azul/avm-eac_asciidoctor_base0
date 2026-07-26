# frozen_string_literal: true

module Avm
  module EacAsciidoctorBase0
    module Logging
      class Error < ::RuntimeError
        attr_reader :level

        def initialize(level, *)
          @level = level
          super(*)
        end
      end
    end
  end
end
