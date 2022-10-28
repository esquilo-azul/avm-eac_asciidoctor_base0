# frozen_string_literal: true

require 'avm/source_generators/base'
require 'eac_templates/core_ext'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module SourceGenerators
      class Base < ::Avm::SourceGenerators::Base
        IDENT = '  '
        JOBS = %w[main_document].freeze
        TEMPLATE_VARIABLES = %w[lib_path name root_module].freeze
        OPTIONS = {}.freeze

        enable_speaker
        enable_simple_cache

        class << self
          def option_list
            OPTIONS.inject(super) { |a, e| a.option(*e) }
          end
        end

        def perform
          template.apply(self, target_path)
        end
      end
    end
  end
end
