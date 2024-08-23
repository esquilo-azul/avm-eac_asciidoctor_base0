# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/documents_owner'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/fs/clearable_directory'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        require_sub __FILE__
        include ::Avm::EacAsciidoctorBase0::DocumentsOwner
        enable_speaker
        enable_simple_cache
        enable_listable
        lists.add_symbol :option, :target_directory
        common_constructor :instance, :options, default: [{}] do
          self.options = self.class.lists.option.hash_keys_validate!(options.symbolize_keys)
        end

        SOURCE_EXTNAMES = %w[.adoc .asc].freeze

        def perform
          infov 'Documents to build', root_document.tree_documents_count
          target_directory.clear
          theme.perform
          root_document.perform
        end

        # @return [Pathname]
        def default_target_directory
          source.path.join('build/site')
        end

        def root_document
          ::Avm::EacAsciidoctorBase0::Instances::Build::Document
            .new(self, nil, source.root_document)
        end

        # @return [Avm::EacAsciidoctorBase0::Sources::Base]
        def source
          instance.application.local_source
        end

        def target_directory
          ::EacRubyUtils::Fs::ClearableDirectory.new(
            options[OPTION_TARGET_DIRECTORY] || default_target_directory
          )
        end

        private

        # @return [Avm::EacAsciidoctorBase0::Instances::Build::Theme]
        def theme_uncached
          ::Avm::EacAsciidoctorBase0::Instances::Build::Theme.new(self)
        end
      end
    end
  end
end
