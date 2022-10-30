# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/fs/clearable_directory'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Build
        require_sub __FILE__
        enable_speaker
        enable_simple_cache
        enable_listable
        lists.add_symbol :option, :target_directory
        common_constructor :source, :options, default: [{}] do
          self.options = self.class.lists.option.hash_keys_validate!(options.symbolize_keys)
        end

        SOURCE_EXTNAMES = %w[.adoc .asc].freeze

        def perform
          infov 'Files to build', source_files.count
          target_directory.clear
          source_files.each(&:perform)
        end

        def default_target_directory
          source.path.join('build')
        end

        def target_directory
          ::EacRubyUtils::Fs::ClearableDirectory.new(
            options[OPTION_TARGET_DIRECTORY] || default_target_directory
          )
        end

        def source_files_uncached
          r = []
          source.content_directory.children.each do |child|
            next unless SOURCE_EXTNAMES.include?(child.extname)

            r << ::Avm::EacAsciidoctorBase0::Sources::Build::Document.new(self, child.basename)
          end
          r
        end
      end
    end
  end
end
