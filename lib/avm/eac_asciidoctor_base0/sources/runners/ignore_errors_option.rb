# frozen_string_literal: true

module Avm
  module EacAsciidoctorBase0
    module Sources
      module Runners
        module IgnoreErrorsOption
          common_concern do
            acts_as_abstract :run_without_rescue

            include ::EacCli::Runner

            runner_definition do
              bool_opt '-g', '--ignore-errors'
            end
          end

          # @return [Boolean]
          delegate :ignore_errors?, to: :parsed

          # @return [void]
          def run
            catcher_send { run_without_rescue }
          rescue ::Avm::EacAsciidoctorBase0::Logging::Error => e
            fatal_error e
          end

          protected

          # @return [Proc]
          def catcher_send(&block)
            if ignore_errors?
              block.call
            else
              ::Avm::EacAsciidoctorBase0::Logging::Catcher.on(&block)
            end
          end
        end
      end
    end
  end
end
