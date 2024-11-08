# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/sources/runners/ignore_errors_option'
require 'os'
require 'eac_cli/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Sources
      module Runners
        class Document
          class Build
            include ::Avm::EacAsciidoctorBase0::Sources::Runners::IgnoreErrorsOption

            runner_with :help do
              bool_opt '-O', '--open'
            end

            protected

            def run_without_rescue
              %w[build open ending].each { |p| send("run_#{p}") }
            end

            private

            def build_document_uncached
              document.build_document
            end

            def run_build
              build_document.perform_self
            end

            def run_ending
              success 'Done'
            end

            def run_open
              return unless parsed.open?

              infov 'Opening', build_document.body_target_path
              ::EacRubyUtils::Envs.local.command(OS.open_file_command,
                                                 build_document.body_target_path).system!
            end
          end
        end
      end
    end
  end
end
