# frozen_string_literal: true

require 'avm/eac_generic_base0/file_formats/base'
require 'eac_ruby_utils/core_ext'

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
