# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Logging
      class Error < ::RuntimeError
        attr_reader :level

        def initialize(level, *args)
          @level = level
          super(*args)
        end
      end
    end
  end
end
