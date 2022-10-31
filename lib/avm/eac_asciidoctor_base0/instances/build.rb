# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/fs/clearable_directory'

module Avm
  module EacAsciidoctorBase0
    module Instances
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
          infov 'Files to build', root_document.tree_documents_count
          target_directory.clear
          root_document.perform
        end

        def default_target_directory
          source.path.join('build')
        end

        def root_document
          ::Avm::EacAsciidoctorBase0::Instances::Build::Document.new(self, nil, nil)
        end

        def target_directory
          ::EacRubyUtils::Fs::ClearableDirectory.new(
            options[OPTION_TARGET_DIRECTORY] || default_target_directory
          )
        end
      end
    end
  end
end
