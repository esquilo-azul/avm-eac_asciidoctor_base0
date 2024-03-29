# frozen_string_literal: true

require 'asciidoctor'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Document
        enable_simple_cache
        enable_speaker
        require_sub __FILE__, include_modules: true
        common_constructor :source, :parent_document, :basename

        # Absolute path to the Asciidoctor file.
        #
        # @return [Pathname]
        def body_path
          root_path.join(
            ::Avm::EacAsciidoctorBase0::Sources::Base::CONTENT_DOCUMENT_BASENAME
          )
        end

        # @return [Avm::EacAsciidoctorBase0::Instances::Build::Document]
        def build_document
          source.build.document(subpath)
        end

        # Absolute path to the document's source root.
        #
        # @return [Pathname]
        def root_path
          source.content_directory.join(subpath)
        end

        # @return [Pathname]
        def subpath
          parent_document.if_present('.'.to_pathname) { |pd| pd.subpath.join(basename) }
        end

        # @return [String]
        def to_s
          subpath.to_path
        end

        private

        def children_uncached
          root_path.children.select(&:directory?)
            .reject { |path| path.basename.to_path == MEDIA_DIRECTORY_BASENAME }
            .map { |path| self.class.new(source, self, path.basename) }
        end
      end
    end
  end
end
