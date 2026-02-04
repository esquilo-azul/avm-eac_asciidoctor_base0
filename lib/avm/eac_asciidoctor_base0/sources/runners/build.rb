# frozen_string_literal: true

require 'os'

module Avm
  module EacAsciidoctorBase0
    module Sources
      module Runners
        class Build
          include ::Avm::EacAsciidoctorBase0::Sources::Runners::IgnoreErrorsOption

          runner_with :help do
            desc 'Build the project'
            arg_opt '-d', '--target-dir', 'Directory to build'
            bool_opt '--open', 'Show the result.'
          end

          private

          # @return [Avm::EacAsciidoctorBase0::Instances::Build]
          def build_uncached
            source.build(target_directory: parsed.target_dir)
          end

          def default_target_directory
            runner_context.call(:project).root.join('build')
          end

          def open
            return unless parsed.open?

            infom "Opening \"#{open_path}\"..."
            ::EacRubyUtils::Envs.local.command(OS.open_file_command, open_path).system!
          end

          def open_path
            build.root_document.body_target_path
          end

          # @return [void]
          def run_without_rescue
            start_banner
            build.perform
            open
          end

          def start_banner
            runner_context.call(:source_banner)
            infov 'Target directory', build.target_directory
          end
        end
      end
    end
  end
end
