# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/instances/build'
require 'eac_cli/core_ext'
require 'os'

module Avm
  module EacAsciidoctorBase0
    module Sources
      module Runners
        class Build
          runner_with :help do
            desc 'Build the project'
            arg_opt '-d', '--target-dir', 'Directory to build'
            bool_opt '--open', 'Show the result.'
          end

          def run
            start_banner
            build.perform
            open
          end

          private

          def build_uncached
            ::Avm::EacAsciidoctorBase0::Instances::Build.new(runner_context.call(:source),
                                                             target_directory: parsed.target_dir)
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

          def start_banner
            runner_context.call(:source_banner)
            infov 'Target directory', build.target_directory
          end
        end
      end
    end
  end
end
