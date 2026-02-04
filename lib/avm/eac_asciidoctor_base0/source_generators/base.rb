# frozen_string_literal: true

module Avm
  module EacAsciidoctorBase0
    module SourceGenerators
      class Base < ::Avm::SourceGenerators::Base
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
