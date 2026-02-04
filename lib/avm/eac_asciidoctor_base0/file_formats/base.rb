# frozen_string_literal: true

module Avm
  module EacAsciidoctorBase0
    module FileFormats
      class Base < ::Avm::EacGenericBase0::FileFormats::Base
        require_sub __FILE__

        VALID_BASENAMES = %w[*.adoc title].freeze
        VALID_TYPES = %w[].freeze
      end
    end
  end
end
